package as3ui.events
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	
	public class SoundEvent extends Event
	{
		private var m_trigger:String;
		
		public static const PLAY	:	String = "SoundEventPlay";
		
		public function SoundEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false, a_trigger:String ="")
		{
			m_trigger = a_trigger;
			
			super(type, bubbles, cancelable);
		}
		
		public function get trigger() : String
		{
			return m_trigger;	
		}
		
		override public function clone():Event
		{ 
			return new SoundEvent(type,bubbles, cancelable,trigger);
		}
	
	}
}