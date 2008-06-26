package se.konstruktor.as3ui.video
{
	import com.akamai.AkamaiConnection;
	import com.akamai.events.AkamaiNotificationEvent;
	import com.akamai.events.AkamaiStatusEvent;
	
	import fl.video.VideoState;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class LivePlayer extends BasePlayer
	{
		
		// Timers
		private var m_timeoutTimer:Timer;

		// Settings
		private var m_isAkamai:Boolean;
		private var m_isLive:Boolean = true;
		
		// Data 
		private static const CONNECTION_AUTH_PARAMS:String = "auth=yyyyy&aifp=zzzz";

		private var m_host:String;
		private var m_file:String;
		private var m_auth:String;
		private var m_requestedURL:String;
		
		
		// Connections 
		private var m_rtmpNC:RTMPConnection;
		private var m_akamaiNC:AkamaiConnection;
		
		public function LivePlayer(a_width:Number, a_height:Number)
		{
			super(a_width, a_height);
		}
		

		private function connectTimeout(e:TimerEvent=null):void
		{
			closeNS();

		}
		
		override public function play(a_url:String=null):void
		{
			m_requestedURL = a_url;
			
			
			if( m_isAkamai ) 
			{
				requestAkamaiConnection();
			}
			else 
			{
//				m_media = parseURL(a_url);
//				if(m_media.isRTMP)
//				{
					connectRTMP();
//				}
			}
		}
		
		override public function pause():void
		{
			if( m_isAkamai ) 
			{
				m_akamaiNC.pause();
			}
			else
			{
				m_rtmpNC.pause();
			}
			setState(VideoState.PAUSED);
		}
		

		override public function stop():void
		{
			if( m_isAkamai ) 
			{
				m_akamaiNC.closeNetStream();
			}
			else
			{
				m_rtmpNC.stop();
			}
			setState(VideoState.STOPPED);
		}


		private function connectRTMP():void
		{
			if(m_rtmpNC == null)
			{
				m_rtmpNC = new RTMPConnection();
				m_rtmpNC.isLive = m_isLive;
				m_rtmpNC.connect(m_requestedURL);
				m_rtmpNC.addEventListener(NetStatusEvent.NET_STATUS,rtmpConnectedHandler);
			} 
			else 
			{
				m_rtmpNC.play(m_rtmpNC.name);
			}

		}		
		
		private function requestAkamaiConnection():void
		{
			verifyAkamaiLocation();	
		}


		
		private function verifyAkamaiLocation():void {
			// Verify Geo Location
			var loader:URLLoader = new URLLoader(new URLRequest(m_requestedURL));
			loader.addEventListener(Event.COMPLETE, loadedAkamaiLocation);
			loader.addEventListener(IOErrorEvent.IO_ERROR , handleIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR ,handleSecurityError);
		}


		private function loadedAkamaiLocation(event:Event):void {
			try {
				var xml:XML = XML(event.target.data);
//				trace("Response received in " + ((getTimer()-startTime)/1000) + " seconds.");
//				trace("Country: " + xml.country);
//				trace("IP: " + xml.ip);
//				trace("Host name: " + xml.hostname);
//				trace("App name: " + xml.appName);
//				trace("Stream name: " + xml.streamName);
				if (xml.authParams.toString() == "Access Denied") {
					trace("Sorry, you are not allowed to access this stream");
					// ToDo: this is a QD fix.
					onNetStatus( new NetStatusEvent( NetStatusEvent.NET_STATUS, false, false,{code:NetStatus.NETCONNECTION_CONNECT_REJECTED}) );
				} else {
					trace("Auth params: "+ xml.authParams);
					trace("Congratulations - you are allowed to watch this stream!");
					m_host = xml.hostname+"/"+xml.appName;
					m_file = xml.streamName;
					m_auth = xml.authParams;
					connectAkamai();
				}
			} catch (e:Error) {
				trace("Invalid xml was returned: " + e.message);
			}
		}

		private function connectAkamai():void {
			if(m_rtmpNC == null)
			{
				m_akamaiNC = new AkamaiConnection();
				m_akamaiNC.createStream = true;
				m_akamaiNC.isLive = m_isLive;
				m_akamaiNC.liveStreamMasterTimeout = 300;
				m_akamaiNC.authParams = CONNECTION_AUTH_PARAMS;
				m_akamaiNC.liveStreamAuthParams = m_auth;
				m_akamaiNC.addEventListener(AkamaiNotificationEvent.CONNECTED,connectedHandler);
	//			ak.addEventListener(AkamaiNotificationEvent.PROGRESS,progressHandler);
	//			ak.addEventListener(AkamaiNotificationEvent.SUBSCRIBED,subscribedHandler);
	//			ak.addEventListener(AkamaiNotificationEvent.UNSUBSCRIBED,unsubscribedHandler);
	//			ak.addEventListener(AkamaiNotificationEvent.SUBSCRIBE_ATTEMPT,subscribeAttemptHandler);
	//			ak.addEventListener(AkamaiStatusEvent.NETSTREAM,netStreamStatusHandler);
	//			ak.addEventListener(AkamaiErrorEvent.ERROR,onError);
				trace("Connection to: "+m_host);
				m_akamaiNC.connect(m_host);
			}
			else
			{
				m_akamaiNC.play(m_file);
			}
			
		}

		private function rtmpConnectedHandler(event:NetStatusEvent):void
		{
			switch ( event.info.code )
			{
				case NetStatus.NETCONNECTION_CONNECT_SUCCESS:
					var conn:RTMPConnection = event.target as RTMPConnection;
					attachNetStream(conn.netStream);
					conn.play(conn.name);
				break;			
			}
		}
		
		private function connectedHandler(e:AkamaiNotificationEvent):void {
			trace("connectedHandler");
			var conn:AkamaiConnection = e.target as AkamaiConnection;
			attachNetStream(conn.netStream);
			conn.play(m_file);
		}
		
		private function attachNetStream(a_ns:NetStream):void
		{
			if(m_ns != null)
			{
				m_ns.removeEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			}
			m_ns = a_ns;
			m_ns.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			m_video.attachNetStream(m_ns);
		}
		
		

		// Getters / Setters
		public function set isAkamai(a_value:Boolean):void
		{
			m_isAkamai = a_value;
		}
		
		public function set isLive(a_value:Boolean):void
		{
			m_isLive = a_value;
		}


		// Catches the netstream status events
		private function netStreamStatusHandler(e:AkamaiStatusEvent):void {
			trace(e.info.code);
		}
		

		// Handle IO errors
		private function handleIOError(e:IOErrorEvent):void {
			trace("IO Error: "+ e);
		}
		// Handle Security Errors
		private function handleSecurityError(e:SecurityErrorEvent):void {
			trace("Security Error: "+ e);
		}
		
	}
}