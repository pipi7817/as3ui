package as3ui.video
{
	import as3ui.UIObject;
	import as3ui.net.NetStatus;
	
	import fl.video.MetadataEvent;
	import fl.video.VideoError;
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;

	public class BasePlayer extends UIObject
	{
		
		// Constants 
		protected static const STATUS_UPDATE_INTERVAL		:	uint	= 250;
		protected static const DELAYED_BUFFERING_INTERVAL	:	uint	= 200;
		protected static const DEBUG						:	Boolean	= false;
		protected static const SEEK_INTERVAL				:	uint	= 250;
		protected static const SEEK_INTERVAL_REPEAT			:	uint	= 4;
		
		protected static const BUFFER_EMPTY				:	String	= "bufferEmpty";
		protected static const BUFFER_FULL				:	String	= "bufferFull";
		protected static const BUFFER_FLUSH				:	String	= "bufferFlush";		

		// Network
		protected var m_nc:NetConnection;
		protected var m_ns:NetStream;
		
		// Timers
		protected var m_statusTimer:Timer;
		protected var m_delayedBufferingTimer:Timer;
		protected var m_recoverSeekTimer:Timer;
		
		// States
		protected var m_state:String = VideoState.DISCONNECTED;
		protected var m_cachedState:String = m_state;
		protected var m_bufferState:String;
		
		// Stored data
		protected var m_streamLength:Number;
		protected var m_contentPath:String;
		protected var m_metadata:Object;
		protected var m_lastValidSeek:Number;
		protected var m_activeSeek:Boolean;

		// Settings
		protected var m_autoSize:Boolean = false;
		protected var m_bufferTime:Number = 1.0;
		
		// Components
		protected var m_video:Video;
		

		public function BasePlayer(a_width:Number, a_height:Number)
		{
			super();
			
			m_statusTimer = new Timer(STATUS_UPDATE_INTERVAL);
			m_statusTimer.addEventListener(TimerEvent.TIMER,onStatusTimer);
			m_statusTimer.start();

			m_delayedBufferingTimer = new Timer(DELAYED_BUFFERING_INTERVAL);
			m_delayedBufferingTimer.addEventListener(TimerEvent.TIMER,doDelayedBuffering);
			
			m_recoverSeekTimer = new Timer(SEEK_INTERVAL,SEEK_INTERVAL_REPEAT);
			m_recoverSeekTimer.addEventListener(TimerEvent.TIMER, recoverSeek);
			
			m_video = new Video(a_width,a_height);
			m_video.opaqueBackground = 0;
			m_contentPath = "";
			m_lastValidSeek = 0;

			setSize(a_width,a_height);
			addChild(m_video);
		}
		
		override public  function get opaqueBackground():Object { return m_video.opaqueBackground;  }
    	override public  function set opaqueBackground(a_value:Object):void { m_video.opaqueBackground = a_value;  }
    		
		override public function setSize(a_width:Number=NaN, a_height:Number=NaN, a_pixelSnap:Boolean=false):void
		{
			m_video.width = a_width;
			m_video.height = a_height;
			super.setSize(a_width,a_height,true);
		}

		public function play(a_url:String = null):void
		{
			if(a_url != null)
			{
				m_contentPath = a_url;

				if(m_ns != null)
				{
					m_ns.close()
				}

				if(m_nc == null)
				{
					m_nc = new NetConnection();
					m_nc.connect(null);
				}
	
				if(m_ns == null)
				{
					createStream();
				}
				
				setState(VideoState.LOADING);
				m_ns.play(source)			

			}
			else 
			{
				switch (state)
				{
					case VideoState.STOPPED:
						_pause(false);
						_seek(0);
						setState(VideoState.PLAYING);
					break;
					
					case VideoState.PAUSED:
						_pause(false);
						setState(VideoState.PLAYING);
					break;
										
				}
			}

		}
		
		public function stop():void
		{
			if (m_state == VideoState.STOPPED || m_ns == null) return;
			
			_pause(true);
			_seek(0);
			setState(VideoState.STOPPED);
			
		}
		
		public function close():void
		{
			closeNS(true);
			setState(VideoState.DISCONNECTED);
			dispatchEvent(new VideoEvent(VideoEvent.CLOSE, false, false, state, playheadTime));
		}
		
		public function clear():void
		{
			if(m_video != null)
			{
				m_video.clear();
			}
		}
		
		public function get sourceWidth():Number
		{
			return m_metadata.width;	
		}

		public function get sourceHeight():Number
		{
			return m_metadata.height;
		}

		public function get source():String
		{
			return m_contentPath;
		}
		
		public function get totalTime():Number
		{
			return m_streamLength;
		}
		
		public function get progress():Number
		{
			return m_ns.bytesLoaded/m_ns.bytesTotal;
		}
		
		public function get playheadPercentage():Number
		{
			if (isNaN(totalTime)) return 0
			return (playheadTime / totalTime );
		}

		public function get state():String
		{
			return m_state;
		}
		
		public function get playheadTime():Number {
			var nowTime:Number = (m_ns == null) ? 0 : m_ns.time;
			if (m_metadata != null && m_metadata.audiodelay != undefined) {
				nowTime -= m_metadata.audiodelay;
				if (nowTime < 0) nowTime = 0;
			}
			return nowTime;
        }
        
		public function get volume():Number {
			if(m_ns != null)
			{
				return m_ns.soundTransform.volume;
			}			
			return 0;
        }

		public function set volume(a_volume:Number):void {

			if(m_ns != null)
			{
				if(m_ns.soundTransform.volume != a_volume)
				{
					m_ns.soundTransform = new SoundTransform(a_volume); //a_volume;
				}
			}
			
		}
        
        public function get bufferTime() : Number
        {
        	return m_bufferTime;
        }
        
        public function set bufferTime(a_value:Number) : void
        {
        	m_bufferTime = a_value;
        }
        
		public function pause():void
		{
			if ( !isValidConnection() )
			{
				if ( m_state == VideoState.CONNECTION_ERROR || m_nc == null )
				{
					throw new VideoError(VideoError.NO_CONNECTION);
				} else {
					return;
				}
			}

			if (m_state == VideoState.PAUSED || m_state == VideoState.STOPPED || m_ns == null) return;

			_pause(true);

			setState(VideoState.PAUSED);
		}

		public function seekPercent(percent:Number):void {
			if ( isNaN(percent) || percent < 0 || percent > 1 || isNaN(totalTime) || totalTime <= 0 )
			{
				throw new VideoError(VideoError.INVALID_SEEK);
			}
			seek(totalTime * percent);
		}
		
		public function seek(a_time:Number):void {

			// we do not allow more seeks until we are out of an active seek
			if (m_activeSeek)
			{
				return;
			}

			if (isNaN(a_time) || a_time < 0)
			{
				throw new VideoError(VideoError.INVALID_SEEK);
			}
			
			if (m_ns == null)
			{
				createStream();
			}

			if( !isNaN(totalTime)  && a_time > totalTime)
			{
				a_time = totalTime;
			}

			_seek(a_time);

		}
		
		private function _seek(a_time:Number):void
		{
			m_activeSeek = true;
			
			if ( m_metadata != null &&
			     m_metadata.audiodelay != undefined &&
				 (isNaN(m_streamLength) || a_time + m_metadata.audiodelay < m_streamLength) )
			{
				a_time += m_metadata.audiodelay;
			}
			

			if(m_ns.time != a_time)
			{
				m_ns.seek(a_time);
				m_bufferState = BUFFER_EMPTY;
			}
		}
		
		private function recoverSeek(e:TimerEvent):void
		{
			_seek(m_lastValidSeek);
		}
		
		private function isValidConnection():Boolean
		{
			if (m_state == VideoState.LOADING) return true;
			if (m_state == VideoState.CONNECTION_ERROR) return false;
			if (m_state != VideoState.DISCONNECTED)
			{
				if ( m_nc == null )
				{
					setState(VideoState.DISCONNECTED);
					return false;
				}
				else
				{
					return true;
				}
			}
			return false;
		}
		 
       	private function _pause(a_doPause:Boolean):void {
			if (a_doPause) {
				m_ns.pause();
			} else {
				m_ns.resume();
			}
		}

        private function createStream():void
        {
        	m_lastValidSeek = 0; 
			m_ns = new NetStream(m_nc);
			m_ns.client = {onMetaData:onMetaData,onCuePoint:onCuePoint};
			m_ns.bufferTime = m_bufferTime;
			m_ns.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			m_video.attachNetStream(m_ns);
        }
        
        private function doDelayedBuffering(event:TimerEvent):void
        {
			switch (m_state)
			{
				case VideoState.PLAYING:
					setState(VideoState.BUFFERING);
				break;
			}        	

			m_delayedBufferingTimer.reset();
        }
        
        
		private function onStatusTimer(event:TimerEvent):void
		{
			if(m_ns == null) return;
			
			if(false &&	 DEBUG) 
			{
				trace("======= onStatusTimer ========");
				trace("ns.time : " + m_ns.time ) ;
				trace("ns.bufferTime : " + m_ns.bufferTime ) ;
				trace("ns.bufferLength : " + m_ns.bufferLength ) ;
				trace("ns.liveDelay : " + m_ns.liveDelay ) ;
				trace("ns.bytesLoaded : " + m_ns.bytesLoaded ) ;
				trace("ns.bytesTotal : " + m_ns.bytesTotal ) ;
				trace("progress : " + m_ns.bytesLoaded/m_ns.bytesTotal ) ;
				trace("streamLength : " + m_streamLength); 
				trace("state : " + m_state); 
			}
			
			dispatchEvent(new ProgressEvent( ProgressEvent.PROGRESS,true,true,m_ns.bytesLoaded,m_ns.bytesTotal) );
		}

		
		private function onAsyncError(event:Event):void
		{

		}
		
		private function onConnection(event:Event):void
		{

		}
        		
        protected function onNetStatus(event:NetStatusEvent):void
        {
			if(DEBUG) trace("======= onNetStatus ========");
			if(DEBUG) trace(" baseplayer: " + event.info.code);



			switch ( event.info.code )
			{
			case NetStatus.NETSTREAM_BUFFER_EMPTY:
				m_bufferState = BUFFER_EMPTY;
				if (m_state == VideoState.PLAYING) {
					m_delayedBufferingTimer.reset();
					m_delayedBufferingTimer.start();
				}
			break;
			
			case NetStatus.NETSTREAM_PLAY_STOP:
			
				// ToDo: proper complete check 
				var tot:int = Math.floor(totalTime);
				var cur:int = Math.ceil(playheadTime);
				
				m_delayedBufferingTimer.reset();
				m_activeSeek = false;
				m_recoverSeekTimer.reset();
				setState(VideoState.STOPPED);
				if(cur >= tot)
				{
					dispatchEvent(new VideoEvent(VideoEvent.COMPLETE,true,true) );
				}
			break;
			
			case NetStatus.NETSTREAM_BUFFER_FULL:
			case NetStatus.NETSTREAM_BUFFER_FLUSH:
				m_delayedBufferingTimer.reset();
				m_bufferState = BUFFER_FULL;
				
				if ((m_state == VideoState.LOADING && m_cachedState == VideoState.PLAYING) || m_state == VideoState.BUFFERING)
				{
					setState(VideoState.PLAYING);
				} 
				else if (m_cachedState == VideoState.BUFFERING)
				{
					m_cachedState = VideoState.PLAYING;
				}
				else if ( m_state == VideoState.LOADING && m_cachedState == VideoState.DISCONNECTED )
				{
					setState(VideoState.PLAYING);	
				}
			break;
			
			case NetStatus.NETSTREAM_PLAY_START:
			{
				if( m_state != VideoState.LOADING) // Still loading firstbuffer
				{
					setState(VideoState.PLAYING);
				}
			}
			break;
			
			case NetStatus.NETSTREAM_SEEK_NOTIFY:
				m_lastValidSeek = m_ns.time;
				m_activeSeek = false;
				m_recoverSeekTimer.reset();
			break;
			
			case NetStatus.NETSTREAM_SEEK_INVALIDTIME:
				if ( m_recoverSeekTimer.currentCount == 0 )
				{
					m_recoverSeekTimer.start();
				}
			break;
							
			
			case NetStatus.NETSTREAM_PLAY_STREAMNOTFOUND:
			case NetStatus.NETSTREAM_FAILED:
			case NetStatus.NETSTREAM_PLAY_FAILED:	
			case NetStatus.NETSTREAM_PLAY_FILESTRUCTUREINVALID:	
			case NetStatus.NETSTREAM_PLAY_NOSUPPORTEDTRACKFOUND:
				setState(VideoState.CONNECTION_ERROR);
			break;
	        }
	        dispatchEvent( new NetStatusEvent(NetStatusEvent.NET_STATUS,true,true,event.info) );
	        
        }

        protected function onMetaData(a_info:Object):void {
			if (m_metadata != null) return;
			m_metadata = a_info;
			if (isNaN(m_streamLength)) m_streamLength = m_metadata.duration;
			dispatchEvent(new MetadataEvent(MetadataEvent.METADATA_RECEIVED, false, false, m_metadata));
        }
 
        protected function onCuePoint(a_info:Object):void {
			dispatchEvent(new MetadataEvent(MetadataEvent.CUE_POINT, false, false, a_info	));
        }		
        
        protected function setState(a_state:String):void
        {
        	if (a_state == m_state) return;
			m_cachedState = m_state;
			m_state = a_state;
			dispatchEvent(new VideoEvent(VideoEvent.STATE_CHANGE, false, false, m_state, playheadTime));
        }
        
        internal function closeNS(a_updateCurrentPos:Boolean=false):void {
			if (m_ns != null) {

				// shut down all the timers
				m_statusTimer.reset();
				m_delayedBufferingTimer.reset();
				m_recoverSeekTimer.reset();

				// remove listeners from NetStream
				m_ns.removeEventListener(NetStatusEvent.NET_STATUS,onNetStatus);

				// close and delete NetStream
				m_ns.close();
				m_ns = null;
			}
		}

	}
}
