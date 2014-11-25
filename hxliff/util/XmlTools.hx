package hxliff.util;

using StringTools;

/**
 * Helpers for Xml object handling
 */
class XmlTools {

	/**
	 * Returns the text content of the first non empty text node child of an element
	 * 
	 * @param the Xml elt
	 * @param if true, recursively parse children elements to find non empty text nodes
	 */
	static public function getSingleTextContent( xml : Xml, ? r : Bool = false ) : String {

		var childs = xml.iterator();

		var tc : String = "";

		while ( childs.hasNext() ) {

			var c : Xml = childs.next();

			if ( c.nodeType == Xml.Comment ) {

				continue;
			}
			if ( r && c.nodeType == Xml.Element ) {

				tc += getSingleTextContent( c , r );

				continue;

			} else if ( c.nodeType != Xml.CData && c.nodeType != Xml.PCData ) {

				throw "expecting CData in "+xml.nodeName+", found "+c.nodeType;
			}
			if ( c.nodeValue != null && c.nodeValue.trim() != "" ) { // avoid problems with empty text nodes

				tc += c.nodeValue;
			}
		}
		return tc;
	}
}