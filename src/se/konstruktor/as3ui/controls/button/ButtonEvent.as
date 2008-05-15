package se.konstruktor.as3ui.controls.button
{
	import flash.events.Event;
	
	public class ButtonEvent extends Event
	{
		public static const DISABLED				:	String = "disabled";
		public static const DOUBLE_CLICK			:	String = "doubleClick";
		public static const ENABLED					:	String = "enabled";
		public static const PRESS					:	String = "press";
		public static const RELEASE					:	String = "release";
		public static const RELEASE_OUTSIDE			:	String = "releaseOutside";
		public static const ROLL_OUT				:	String = "rollOut";
		public static const ROLL_OUT_WHILE_DOWN		:	String = "rollOutWhileMouseDown";
		public static const ROLL_OVER				:	String = "rollOver";
		public static const ROLL_OVER_WHILE_DOWN	:	String = "rollOverWhileMouseDown";
		public static const STATE					:	String = "state";
		
		public function ButtonEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new ButtonEvent(type,bubbles, cancelable);
		}
	
	}
}