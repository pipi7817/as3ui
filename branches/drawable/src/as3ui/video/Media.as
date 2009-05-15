/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.video
{
	import fl.video.VideoError;
	
	public class Media
	{
		public var isRelative:Boolean;
		public var isRTMP:Boolean;
		public var protocol:String;
		public var serverName:String;
		public var portNumber:String;
		public var appName:String;
		public var streamName:String;
		public var wrappedURL:String;
		public var url:String;
		
		public function Media()
		{
		}
		
		public function parseURL(a_url:String):void
		{		
			// 					/$(protocol):\/(server):(port)/(appname|appdir/appname)/(stream_name)/i
			var pattern:RegExp = /^((?:http|https|rtmp|rtmp(?:t|s|e|te)):\/(?=\/)|\/)\/?([a-z_\-0-9.%]+)(?::([0-9]+))?\/(?!\?)([^\/]+(?:\/[^\/]+(?=\/))?)\/?(.*)/i;
			var match:Object = pattern.exec(a_url);		

			if(match)
			{
				this.url 		= a_url;
				this.protocol	= match[1];
				this.serverName	= match[2];
				this.portNumber	= match[3];
				this.appName	= (match[4]=="")?null:match[4].toString().replace(/\.flv/,"");
				this.streamName	= (match[5]=="")?null:match[5].toString().replace(/\.flv/,"");
				this.isRTMP		= this.protocol.match(/^(?:rtmp|rtmp(?:t|s|e|te))/i)?true:false;
				this.isRelative = this.protocol == "/";
			}
			else 
			{
				throw new VideoError(VideoError.INVALID_SOURCE, a_url);
			}
		}
	}
}