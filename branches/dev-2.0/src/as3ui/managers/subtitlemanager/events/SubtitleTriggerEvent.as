package as3ui.managers.subtitlemanager.events
{
	import flash.events.Event;
	public class SubtitleTriggerEvent extends Event
	{
		public static const ACTIVATE	:	String = "TriggerEventActivate";
		public static const DEACTIVATE	:	String = "TriggerEventDeactivate";
		public static const UPDATE		:	String = "TriggerEventUpdate";
		
		private var m_data:Object;

		public function SubtitleTriggerEvent(type:String, a_data:Object = null, bubbles:Boolean = true,cancelable:Boolean = true)
		{
			m_data = a_data;
			super(type, bubbles, cancelable);
		}

		public function get data() : Object
		{
			return m_data;
		}
				
		override public function clone():Event
		{ 
			return new SubtitleTriggerEvent(type,data,bubbles, cancelable);
		}
	
	}
}