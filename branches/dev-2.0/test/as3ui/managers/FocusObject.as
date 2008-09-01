package as3ui.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FocusObject implements IFocusObject, IEventDispatcher
	{

		internal var focus:Boolean;
		internal var enabled:Boolean;
		private var eventDispatcher:EventDispatcher;
		
		public function FocusObject()
		{
			eventDispatcher = new EventDispatcher();	
		}
		
		public function setFocus(value:Boolean = true):void
		{
			focus = value;
		}
		
		public function get isFocus():Boolean
		{
			return focus;
		}
		
		public function get isEnabled():Boolean
		{
			return enabled;
		}


		/*
		 * IEventDispatcher methods
		 */

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void { eventDispatcher.addEventListener.apply(null, arguments); }
        public function dispatchEvent(event:Event):Boolean { return eventDispatcher.dispatchEvent.apply(null, arguments); }
        public function hasEventListener(type:String):Boolean { return eventDispatcher.hasEventListener.apply(null, arguments); }
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void { eventDispatcher.removeEventListener.apply(null, arguments); }
        public function willTrigger(type:String):Boolean { return eventDispatcher.willTrigger.apply(null, arguments); }

	}
}