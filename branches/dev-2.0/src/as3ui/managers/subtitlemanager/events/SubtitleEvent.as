package as3ui.managers.subtitlemanager.events
{
	import flash.events.Event;
	public class SubtitleEvent extends Event
	{
		public static const SHOW	:	String = "SubtitleEventShow";
		public static const HIDE	:	String = "SubtitleEventHide";
		public static const CLEAR	:	String = "SubtitleEventClear";

		private var m_text:String;

		public function SubtitleEvent(type:String, a_text:String ="", bubbles:Boolean = false,cancelable:Boolean = false)
		{
			m_text = a_text;
			super(type, bubbles, cancelable);
		}
		
		public function get text() : String
		{
			return m_text;	
		}
		
		override public function clone():Event
		{ 
			return new SubtitleEvent(type,text,bubbles, cancelable);
		}
	
	}
}