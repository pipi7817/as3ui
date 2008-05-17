package se.konstruktor.as3ui.flash.uisprite
{
	import flash.events.Event;
	
	public class UISpriteEvent extends Event
	{
		public static const SHOW				:	String = "UISpriteShow";
		public static const SHOW_COMPLETE		:	String = "UISpriteShowComplete";
		public static const HIDE				:	String = "UISpriteHide";
		public static const HIDE_COMPLETE		:	String = "UISpriteHideComplete";
		public static const MOVE				:	String = "UISpriteMove";
		public static const MOVE_COMPLETE		:	String = "UISpriteMoveComplete";
		public static const RESIZE				:	String = "UISpriteResize";
		
		public function UISpriteEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new UISpriteEvent(type,bubbles, cancelable);
		}
	
	}
}