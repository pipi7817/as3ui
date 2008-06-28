package se.konstruktor.as3ui.video {
	import fl.video.VideoError;
	
	
	public class VideoURL {
		
		public function VideoURL() { } 
		
		public static function parseURL(a_url:String):VideoMedia
		{
			var parseResults:VideoMedia = new VideoMedia();
			
			// 					/$(protocol):\/(server):(port)/(appname|appdir/appname)/(stream_name)/i
			var pattern:RegExp = /^((?:http|https|rtmp|rtmp(?:t|s|e|te)):\/(?=\/)|\/)\/?([a-z_\-0-9.%]+)(?::([0-9]+))?\/(?!\?)([^\/]+(?:\/[^\/]+(?=\/))?)\/?(.*)/i;
			var match:Object = pattern.exec(a_url);		

			if(match)
			{
				parseResults.protocol	= match[1];
				parseResults.serverName	= match[2];
				parseResults.portNumber	= match[3];
				parseResults.appName	= (match[4]=="")?null:match[4].toString().replace(/\.flv/,"");
				parseResults.streamName	= (match[5]=="")?null:match[5].toString().replace(/\.flv/,"");
				parseResults.isRTMP		= parseResults.protocol.match(/^(?:rtmp|rtmp(?:t|s|e|te))/i)?true:false;
				parseResults.isRelative = parseResults.protocol == "/";
			}
			else 
			{
				throw new VideoError(VideoError.INVALID_SOURCE, a_url);
			}
			
			return parseResults;
//
//
//			// get protocol
//			var startIndex:int = 0;
//			var endIndex:int = a_url.indexOf(":/", startIndex);
//			if (endIndex >= 0) {
//				endIndex += 2;
//				parseResults.protocol = a_url.slice(startIndex, endIndex).toLowerCase();
//				parseResults.isRelative = false;
//			} else {
//				parseResults.isRelative = true;
//			}
//			
//			if ( parseResults.protocol != null &&
//			     ( parseResults.protocol == "rtmp:/" ||
//			       parseResults.protocol == "rtmpt:/" ||
//			       parseResults.protocol == "rtmps:/" ||
//			       parseResults.protocol == "rtmpe:/" ||
//			       parseResults.protocol == "rtmpte:/" ) )
//			{
//				parseResults.isRTMP = true;
//				
//				startIndex = endIndex;
//
//				if (a_url.charAt(startIndex) == '/') {
//					startIndex++;
//					// get server (and maybe port)
//					var colonIndex:int = a_url.indexOf(":", startIndex);
//					var slashIndex:int = a_url.indexOf("/", startIndex);
//					if (slashIndex < 0) {
//						if (colonIndex < 0) {
//							parseResults.serverName = a_url.slice(startIndex);
//						} else {
//							endIndex = colonIndex;
//							parseResults.portNumber = a_url.slice(startIndex, endIndex);
//							startIndex = endIndex + 1;
//							parseResults.serverName = a_url.slice(startIndex);
//						}
//						return parseResults;
//					}
//					if (colonIndex >= 0 && colonIndex < slashIndex) {
//						endIndex = colonIndex;
//						parseResults.serverName = a_url.slice(startIndex, endIndex);
//						startIndex = endIndex + 1;
//						endIndex = slashIndex;
//						parseResults.portNumber = a_url.slice(startIndex, endIndex);
//					} else {
//						endIndex = slashIndex;
//						parseResults.serverName = a_url.slice(startIndex, endIndex);
//					}
//					startIndex = endIndex + 1;
//				}
//
//				// handle wrapped RTMP servers bit recursively, if it is there
//				trace(a_url.charAt(startIndex));
//				if (a_url.charAt(startIndex) == '?') {
//					var subURL:String = a_url.slice(startIndex + 1);
//					var subParseResults:VideoMedia = parseURL(subURL);
//					if (subParseResults.protocol == null || !subParseResults.isRTMP) {
//						throw new VideoError(VideoError.INVALID_SOURCE, a_url);
//					}
//					parseResults.wrappedURL = "?";
//					parseResults.wrappedURL += subParseResults.protocol;
//					if (subParseResults.serverName != null) {
//						parseResults.wrappedURL += "/";
//						parseResults.wrappedURL +=  subParseResults.serverName;
//					}
//					if (subParseResults.portNumber != null) {
//						parseResults.wrappedURL += ":" + subParseResults.portNumber;
//					}
//					if (subParseResults.wrappedURL != null) {
//						parseResults.wrappedURL += "/";
//						parseResults.wrappedURL +=  subParseResults.wrappedURL;
//					}
//					parseResults.appName = subParseResults.appName;
//					parseResults.streamName = subParseResults.streamName;
//					return parseResults;
//				}
//				
//				// get application name
//				endIndex = a_url.indexOf("/", startIndex);
//				if (endIndex < 0) {
//					parseResults.appName = a_url.slice(startIndex);
//					return parseResults;
//				}
//				parseResults.appName = a_url.slice(startIndex, endIndex);
//				startIndex = endIndex + 1;
//
//				// check for instance name to be added to application name
//				endIndex = a_url.indexOf("/", startIndex);
//				if (endIndex < 0) {
//					parseResults.streamName = a_url.slice(startIndex);
//					// strip off .flv if included
//					if (parseResults.streamName.slice(-4).toLowerCase() == ".flv") {
//						parseResults.streamName = parseResults.streamName.slice(0, -4);
//					}
//					return parseResults;
//				}
//				parseResults.appName += "/";
//				parseResults.appName += a_url.slice(startIndex, endIndex);
//				startIndex = endIndex + 1;
//					
//				// get flv name
//				parseResults.streamName = a_url.slice(startIndex);
//				// strip off .flv if included
//				if (parseResults.streamName.slice(-4).toLowerCase() == ".flv") {
//					parseResults.streamName = parseResults.streamName.slice(0, -4);
//				}
//				
//			} else {
//				// is http, just return the full url received as streamName
//				parseResults.isRTMP = false;
//				parseResults.streamName = a_url;
//			}
//			return parseResults;			
		}

	}
}
