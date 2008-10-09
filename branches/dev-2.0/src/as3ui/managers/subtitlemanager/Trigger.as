package as3ui.managers.subtitlemanager
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Trigger extends EventDispatcher
	{
		private var m_delayTime:Number;
		private var m_timeoutTime:Number;
		private var m_text:String;
		private var m_delay:Timer;
		private var m_timout:Timer;
		private var m_playing:Boolean;
		private var m_active:Boolean; 
		
		public function Trigger(a_text:String,a_delayTime:Number = 0, a_timeoutTime:Number = 0 )
		{
			m_text =  a_text;
			m_delayTime = a_delayTime;
			m_timeoutTime = a_timeoutTime;
		}
		
		public function get text():String
		{
			return m_text;
		}

		private function removeListners() : void
		{
			if(m_delay != null) 
			{
				m_delay.removeEventListener(TimerEvent.TIMER_COMPLETE,onDelayComplete);
			}
			
			if(m_timout != null)
			{
				m_timout.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeoutComplete);				
			}
		}
		
		public function reset(a_event:Event = null) : void
		{
			removeListners();
			
			if(m_delay != null)
			{
				m_delay.stop();				
				m_delay = null;
			}
			
			if(m_timout != null)
			{
				m_timout.stop();				
				m_timout = null;
			}
			
			if(!m_playing) 
			{
				m_active = false;
			}
			
			m_playing = false;
		}
		
		private function onTimeoutComplete(a_event:Event = null) : void
		{
			reset();
			m_active = false;
			dispatchEvent(new Event(Event.DEACTIVATE));
		}
		
		private function onDelayComplete(a_event:Event = null) : void
		{
			if(!m_active)
			{
				m_active = true;
				dispatchEvent(new Event(Event.ACTIVATE));
			}
			
			if(m_timeoutTime>0)
			{
				m_timout = new Timer(m_timeoutTime,1);
				m_timout.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeoutComplete);
				m_timout.start();
			}
			else
			{
				onTimeoutComplete();
			}


		}

		public function play() : void
		{
			if(m_playing)
			{
				reset();	
			}
			
			m_playing = true;
			
			if(m_delayTime>0)
			{
				m_delay = new Timer(m_delayTime,1);
				m_delay.addEventListener(TimerEvent.TIMER_COMPLETE,onDelayComplete);
				m_delay.start();
			}
			else
			{
				onDelayComplete();
			}
		}

		override public function toString() : String
		{
			return "[Trigger "+m_text+"]";
		}
	}
}