package hxliff;

using hxliff.util.XmlTools;

typedef TransUnit = {

	var id : String;
	var transUnit : String;
}

@:expose("hxliff.Parser")
class Parser {

	static inline var NODE_NAME_XLIFF : String = "xliff";
	static inline var NODE_NAME_FILE : String = "file";
	static inline var NODE_NAME_HEADER : String = "header";
	static inline var NODE_NAME_BODY : String = "body";
	static inline var NODE_NAME_TRANSUNIT : String = "trans-unit";
	static inline var NODE_NAME_SOURCE : String = "source";
	static inline var NODE_NAME_TARGET : String = "target";

	static inline var ATTR_NAME_ID : String = "id";
	static inline var ATTR_NAME_SOURCE_LANG : String = "source-language";
	static inline var ATTR_NAME_TARGET_LANG : String = "target-language";

	public static function parse(s:String):{ locale: String, data: Dynamic } {

		var n : Xml = Xml.parse(s);

		var tus : Dynamic = {};

		var locale : Null<String> = null;

		for(xlfXml in n.elements()) {

			switch (xlfXml.nodeName.toLowerCase()) {

				case NODE_NAME_XLIFF:

					for ( fXml in xlfXml.elements() ) {

						switch(fXml.nodeName.toLowerCase()) {

							case NODE_NAME_FILE:

								for (xlfAttr in fXml.attributes()) {

									switch(xlfAttr.toLowerCase()) {

										case ATTR_NAME_SOURCE_LANG:

											if (locale == null) {

												locale = fXml.get(xlfAttr);
											}

										case ATTR_NAME_TARGET_LANG:

											locale = fXml.get(xlfAttr);
									}
								}

								for ( bXml in fXml.elements() ) {

									switch (bXml.nodeName.toLowerCase()) {

										case NODE_NAME_BODY:

											for( tuXml in bXml.elements() ) {

												switch (tuXml.nodeName) {
					
													case NODE_NAME_TRANSUNIT:

														var tu : TransUnit = xml2TransUnit(tuXml);

														Reflect.setField( tus, tu.id, tu.transUnit );

													default:

														throw "unexpected node " + tuXml.nodeName;
												}

											}

										case NODE_NAME_HEADER: // nothing, not yet supported

										default:

											throw "unexpected node " + bXml.nodeName;
									}
								}

							default:

								throw "unexpected node " + fXml.nodeName;
						}
					}

				default:

					throw "unexpected node " + xlfXml.nodeName;
			}
		}
		return { locale: locale, data: tus };
	}

	static function xml2TransUnit(n:Xml):TransUnit {

		var id:Null<String> = null;
		var val:Null<String> = null;

		for (tuAttr in n.attributes()) {

			switch(tuAttr.toLowerCase()) {

				case ATTR_NAME_ID:

					id = n.get(tuAttr);
			}
		}

		for(tuXml in n.elements()) {

			switch (tuXml.nodeName.toLowerCase()) {

				case NODE_NAME_SOURCE:

					if (val == null) {

						val = tuXml.getSingleTextContent();
					}

				case NODE_NAME_TARGET:

					val = tuXml.getSingleTextContent();

				default:

					throw "unexpected node "+tuXml.nodeName;
			}
		}
		return { id: id, transUnit: val };
	}
}