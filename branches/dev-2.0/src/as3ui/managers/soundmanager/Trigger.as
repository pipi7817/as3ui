package as3ui.managers.soundmanager
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getDefinitionByName;
	
	public class Trigger extends EventDispatcher
	{
		private var m_sound:Sound;
		private var m_channel:SoundChannel;
		private var m_linkage:String;
		private var m_startTime:Number;
		private var m_pauseTime:Number = -1;
		private var m_loops:int;
		private var m_transformer:SoundTransform;
		
		public function Trigger(a_linkage:String,a_startTime:Number = 0, a_loops:int = 0 )
		{
			m_linkage =  a_linkage;
			m_startTime = a_startTime;
			m_loops = a_loops;
		}
		
		private function getSound() : Sound
		{
			var snd:Sound;
			
			try 
			{
				var classref:Class = getDefinitionByName(m_linkage) as Class;
				snd = new  classref()
			}
			catch(e:Error)
			{
				trace("error:" + e.getStackTrace());
				snd = new Sound();
			}
			
			return snd;
		}
		
		private function reset(a_event:Event = null) : void
		{
			if(m_channel != null)
			{
				m_channel.removeEventListener(Event.SOUND_COMPLETE,reset);
				m_channel = null;
			}
	
			m_sound = null;
		}
		
		public function play() : void
		{
			if(m_sound == null)
			{
				m_sound = getSound();
			}
			trace("play" + m_sound + "::" + m_transformer);
			
			m_channel = m_sound.play(m_startTime,m_loops,m_transformer);
			m_channel.addEventListener(Event.SOUND_COMPLETE,reset);
		}
		
		public function stop() : void
		{
			if(m_channel != null)
			{
				m_channel.stop();
			}
			
			reset();
		}
		
		public function pause() : void
		{
			var transformer:SoundTransform;
			
			if(m_channel != null)
			{
				transformer = m_channel.soundTransform;
				m_channel.removeEventListener(Event.SOUND_COMPLETE,reset);
				m_pauseTime = m_channel.position;
				m_channel.stop();
			}
			reset();
			
			m_transformer = transformer;
		}
		
		public function resume() : void
		{
			if(paused)
			{
				m_sound = getSound(); 
				m_channel = m_sound.play(m_pauseTime,m_loops,m_transformer);
				m_pauseTime = -1;
			}
		}
		
		public function set volume(a_value:Number) : void
		{
			m_transformer = new SoundTransform(a_value);
			if(m_channel != null)
			{
				m_channel.soundTransform = m_transformer;
			}
		}
		
		public function get volume() : Number
		{
			if(m_channel != null)
			{
				return 	m_channel.soundTransform.volume;
			}
			return 0;
		}
		
		public function get playing() : Boolean
		{
			if(m_channel != null && m_sound != null)
			{
				return true;
			}
			
			return false;
		}
		
		public function get paused() : Boolean
		{
			return ( m_pauseTime >= 0 );
		}

		override public function toString() : String
		{
			return "[Trigger "+m_linkage+"]";
		}
	}
}