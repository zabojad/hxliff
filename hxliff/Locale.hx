package hxliff;

abstract Locale(String) from String to String {
	
	public function getLang() : String {

		return this;
	}

	public function getRegion() : String {

		return ""; // TODO
	}
}