package as3ui.managers
{
	import flash.events.IEventDispatcher;
	
	public interface IFocusObject extends IEventDispatcher
	{
		function setFocus(value:Boolean = true):void;
		function get isFocus():Boolean;
		function get isEnabled():Boolean;
	}
}