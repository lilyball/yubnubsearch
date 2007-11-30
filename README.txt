YubNubSearch
============

Kevin Ballard  
[http://kevin.sb.org](http://kevin.sb.org)  
[kevin@sb.org](mailto:kevin@sb.org)

YubNubSearch is a [SIMBL][] bundle which provides access to [YubNub][] from Safari's search field.

To use, install [SIMBL][] first if you don't already have it, then simply copy YubNubSearch.bundle
into `/Library/Application Support/SIMBL/Plugins/` and restart Safari.

To use, type stuff into the search field. Everything will be sent to [YubNub][] instead of Google.
If the string starts with "g " it will be sent to Google anyway, with the "g " stripped off.

Version History:

 * 1.1: Searches prefixed with "g " now default to Google without going through YubNub
		Holding down Shift no longer defaults to Google (this was behaving inconsistently)
		"&" and ";" are now escaped for YubNub

 * 1.0: Initial release

[SIMBL]: http://www.culater.net/software/SIMBL/SIMBL.php "Simple Input Manager Bundle Loader"
[YubNub]: http://www.yubnub.org
