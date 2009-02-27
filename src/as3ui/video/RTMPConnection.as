package as3ui.video
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	
	import as3ui.net.NetStatus;

	public class RTMPConnection extends EventDispatcher
	{
		private var m_nc:NetConnection;
		private var m_ns:NetStream;

		// Settings
		private var m_objectEncoding:uint = ObjectEncoding.AMF0;
		private var m_proxyType:String = "best";
		
		// Timers
		
		// Status
		private var m_playingLiveStream:Boolean;
		private var m_streamEstablished:Boolean;
		private var m_connectionEstablished:Boolean;
		private var m_isPaused:Boolean;
		private var m_isPlaying:Boolean;
		private var m_isLive:Boolean = false;

		// Data
		private var m_pendingLiveStreamName:String;
		private var m_media:Media;
		private var m_metaData:Object;
		
		public function RTMPConnection()
		{

		}
		
		private function setupConnection():void
		{
			if(m_nc == null)
			{
				m_nc = new NetConnection();
				m_nc.objectEncoding = m_objectEncoding;
				m_nc.proxyType = m_proxyType;
				m_nc.client = this;
				m_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);		
			}
		}
		
		private function cleanConnection():void
		{
			if(m_nc != null)
			{		
				if( m_nc.connected ) m_nc.close();
				m_ns.close();
				m_isPaused = false;
			}
		}
		
		private function onNetStatus(event:NetStatusEvent):void
		{
//			trace("============ onNetStatus ============");
//			trace(event.info.code);
			switch (event.info.code)
			{
				case NetStatus.NETCONNECTION_CONNECT_SUCCESS:
					m_connectionEstablished = true;
					setupStream();
				break;
			}

			dispatchEvent(event);
		}
		
		private function setupStream():void
		{
			m_ns = new NetStream(m_nc);
			m_ns.client = this;
			m_streamEstablished = true;
		}
		
		
		private function getConnectString():String
		{
			if (m_media == null)
			{
				return "";
			}
			else 
			{
				return m_media.protocol + ((m_media.serverName == null) ? "" : "/" + m_media.serverName + ((m_media.portNumber == null) ? "" : (":" + m_media.portNumber)) + "/") + ((m_media.wrappedURL == null) ? "" : m_media.wrappedURL + "/") + m_media.appName;
			}
		}
		
		public function connect(a_url:String):void
		{
			m_media = new Media();
			m_media.parseURL(a_url);
			cleanConnection();
			setupConnection();
			
			m_nc.connect( getConnectString() );
			
		}

		public function play(name:String):void {
			if (m_streamEstablished)
			{
				if (m_isLive)
				{
					if(m_isPaused)
					{
						m_ns.resume();
					}
					else
					{
						m_pendingLiveStreamName = name;
						m_playingLiveStream = true;
						m_ns.play(name,-1);
					}
				} else {
					m_playingLiveStream = false;
					if ( m_isPaused )
					{
						m_ns.resume();
					}
					else
					{
						if(!m_isPlaying)
						{
							m_ns.play(name,0);
							m_ns.resume();
						}
					}
				}
	
				m_isPaused = false;
				m_isPlaying = true;
			} else {
				// ERROR "Cannot play, pause, seek or resume since the stream is not defined";
			}
		}

		public function pause():void {
			if (m_streamEstablished) {
				m_ns.pause();
				m_isPaused = true;
			} else {
				// ERROR "Cannot play, pause, seek or resume since the stream is not defined";
			}
		}
		
		public function stop():void
		{
			if (m_streamEstablished) {
				m_ns.pause();
				m_isPaused = false;
				m_isPlaying = false;
				if(m_isLive)
				{
					m_isPaused = true;
					m_isPlaying = false;
				}

			} else {
				// ERROR "Cannot play, pause, seek or resume since the stream is not defined";
			}
		}
		
		// Getters / Setters
		
		public function get name():String
		{
			return m_media.streamName;
		}
		
		public function get netStream():NetStream
		{
			return m_ns;
		}
		
		public function get isLive():Boolean {
			return m_isLive;
		}

		public function set isLive(a_isLive:Boolean):void {
			m_isLive = a_isLive;
		}

		// TODO: ADD functionality
	   public function onLastSecond(... args):void
       {
       		if(m_ns) m_ns.seek(0);
       }
       
       
		public function onBWDone(... args):void
		{
			return;
		}
		
		public function close(... args):void
		{
			return;
		}

		public function onBWCheck(... args):void
		{
			return;		
		}
		
		public function onMetaData(a_info:Object):void
		{
			m_metaData = a_info;
        }
 
        public function onCuePoint(a_info:Object):void {
			return;
        }
        
        public function onPlayStatus(... args):void
        {
        	return;
        }
	}
}