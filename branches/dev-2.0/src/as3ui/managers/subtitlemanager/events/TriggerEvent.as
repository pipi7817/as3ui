package as3ui.managers.subtitlemanager.events
{
	import flash.events.Event;
	public class TriggerEvent extends Event
	{
		public static const ACTIVATE	:	String = "TriggerEventActivate";
		public static const DEACTIVATE	:	String = "TriggerEventDeactivate";
		public static const UPDATE		:	String = "TriggerEventUpdate";

		public function TriggerEvent(type:String, bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new TriggerEvent(type,bubbles, cancelable);
		}
	
	}
}