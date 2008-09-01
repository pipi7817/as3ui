package as3ui.events
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		public static const SHOW				:	String = "UIShow";
		public static const SHOW_COMPLETE		:	String = "UIShowComplete";
		public static const HIDE				:	String = "UIHide";
		public static const HIDE_COMPLETE		:	String = "UIHideComplete";
		public static const MOVE				:	String = "UIMove";
		public static const MOVE_COMPLETE		:	String = "UIMoveComplete";
		public static const RESIZE				:	String = "UIResize";
		
		public function UIEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new UIEvent(type,bubbles, cancelable);
		}
	
	}
}