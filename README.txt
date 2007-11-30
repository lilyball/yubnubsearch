YubNubSearch
============

Kevin Ballard  
[http://kevin.sb.org](http://kevin.sb.org)  
[kevin@sb.org](mailto:kevin@sb.org)

YubNubSearch is a [SIMBL][] bundle which provides access to [YubNub][] from Safari's search field.

To use, install [SIMBL][] first if you don't already have it, then simply copy YubNubSearch.bundle
into `/Library/Application Support/SIMBL/Plugins/` and restart Safari.

To use, type stuff into the search field. Everything will be sent to [YubNub][] instead of Google.
If you want to use Google anyway (say, [YubNub][] is being really slow), just hold shift when you press
return and it will fall back to the default search behavior. If the search string has a leading "g " it
will be stripped (this way if you use [YubNub][]'s google search command and it's slow, you can use Google
instead to search for the exact same string).

Version History:

 * 1.0: Initial release

[SIMBL]: http://www.culater.net/software/SIMBL/SIMBL.php "Simple Input Manager Bundle Loader"
[YubNub]: http://www.yubnub.org
