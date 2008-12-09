package as3ui.uiobject
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	public interface ILayoutable extends IEventDispatcher
	{
		function get margin():Margin;
		function get padding():Padding;
		function get width():Number;
		function get height():Number;
		function get parent():DisplayObjectContainer;
		function get numChildren():int;
		
		function set width(value:Number):void;
		function set height(value:Number):void;
		
		function getChildAt(index:int):DisplayObject;
		
	}
}