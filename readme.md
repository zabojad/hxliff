#Cross platform XLIFF parser

Author: Thomas Fétiveau, www.tokom.fr

Cross platform XLIFF parser coded with haxe (www.haxe.org). This XLIFF implementation is far from beeing completed and has been compiled and tested so far only in javascript and as3.

Further improvments will be pushed and more platform are to be supported.

If you use and enjoy this lib, feel free to contribute by reporting bugs, proposing improvments...

##Last release Binaries

You can find the Hxliff binaries for each platform there:

 - for javascript : http://www.tokom.fr/hxliff/hxliff.js.zip

 - for Flash / Flex / as3 : http://www.tokom.fr/hxliff/hxliff.swc.zip

##Using Hxliff in javascript

 - Load the hxliff script into your current DOM document, for example with a &lt;script&gt; tag like this:

```
 <script type="text/javascript" src="http://localhost/accor/lib/hxliff.js"></script>
```

 - Then, call the hxliff parser like this (here using JQuery to load the .xlf file):

 ```
 // store parameters in a single object
 window.params = {};

 // (...)

 // init the langs object
 window.params.langs = {};
 
 // load and parse the XLIFF file
 $(document).load( "http://mydomain/en.xlf", function(data,status,hxr) {

		if ( status == "error" ) {

			console.log("ERROR while loading XLIFF file: "+xhr.status+" "+xhr.statusText);

		} else {

			var ldata = window.hxliff.Parser.parse(data);

			window.params.langs[ldata.locale] = ldata.data;

		}
	});


// translate some text
$("#myFirstText").text(window.params.langs.en["1"]); // assign text from trans-unit with id "1" of locale "en" to myFirstText
 ```

##Using Hxliff in Flash / Flex / as3

 - Add the hxliff.swc to your library path (if you're using Flash professional, got to the pusblish settings > action script settings > library > add path to swc)

 - On the first frame of your fla (or in your project main class), add this before anything else:

 ```
 haxe.initSwc(root as MovieClip);
 ```

 - Then wherever you want in your code, you can call the hxliff parser to parse XLIFF content:

```
import hxliff.Parser;

// (...) 

var langs : Object = {};

// (...)

// Load and parse the XLIFF file
var r:URLRequest = new URLRequest("http://mydomain/en.xlf");
var l:URLLoader = new URLLoader();

l.addEventListener(Event.COMPLETE, function(e){

		var o : Object = hxliff.Parser.parse(e.target.data);
		// trace("Received data for locale "+o.locale);
		langs[o.locale] = o.data;
	
	}, false, 0, true);

l.load(r);

// (...)

// retreive a translation unit for the current locale
tf.text = langs["en"][transUnitId];
```

##Compilation

To recompile hxliff, download and install the last release version of haxe on www.haxe.org

Then, just run the hxml script like this:

```
haxe build.hxml
```

##License

Hxliff is open-source, released under the MIT licence, see license.txt.