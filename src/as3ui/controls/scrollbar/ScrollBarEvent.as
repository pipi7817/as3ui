package as3ui.controls.scrollbar
{
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		public static const SCROLL			:	String = "scrollUpdate";
		
		public function ScrollBarEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new ScrollBarEvent(type,bubbles, cancelable);
		}
	
	}
}