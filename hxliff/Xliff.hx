package hxliff;

class Xliff {

	public function new(source : String, target : String, transUnits : Map<String, TransUnit>) {

		this.source = source;
		this.target = target;
		this.transUnits = transUnits;
	}

	var source : String;
	var target : String;
	var transUnits : Map<String, TransUnit>;

	///
	// Public Interface
	//

	static public function parse(data : String) : Xliff {

		return Parser.parse(data);
	}

	public function merge(hxliff : Xliff) : Xliff {

		// TODO

		return this;
	}

	public function translate(str : String, to : Locale) : Null<String> {

		// TODO

		return null;
	}

	public function get(id : String, ? l : Null<Locale>) : Null<String> {

		if (l == null) {

			l = source;
		}
		if (l.getLang() == source) {

			return transUnits.get(id).source;

		} else if (l.getLang() == target) {

			return transUnits.get(id).target;
		
		} else  {

			trace("Unexpected lang " + l);
		}

		return null;
	}
}