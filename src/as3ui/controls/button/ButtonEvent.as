/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.controls.button
{
	import flash.events.Event;
	
	public class ButtonEvent extends Event
	{
		public static const DISABLED				:	String = "buttonDisabled";
		public static const CLICK					:	String = "buttonClick";
		public static const DOUBLE_CLICK			:	String = "buttonDoubleClick";
		public static const ENABLED					:	String = "buttonEnabled";
		public static const PRESS					:	String = "buttonPress";
		public static const TOGGLE					:	String = "buttonToggle";
		public static const RELEASE					:	String = "buttonRelease";
		public static const RELEASE_OUTSIDE			:	String = "buttonReleaseOutside";
		public static const ROLL_OUT				:	String = "buttonRollOut";
		public static const ROLL_OUT_WHILE_DOWN		:	String = "buttonRollOutWhileMouseDown";
		public static const ROLL_OVER				:	String = "buttonRollOver";
		public static const ROLL_OVER_WHILE_DOWN	:	String = "buttonRollOverWhileMouseDown";
		public static const CHANGE_STATE			:	String = "buttonChangeState";
		
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