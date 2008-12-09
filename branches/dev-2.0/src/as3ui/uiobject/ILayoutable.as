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
		function get align():String;
		function get float():String;
		function get top():Number;
		function get right():Number;
		function get bottom():Number;
		function get left():Number;
				
		function set width(value:Number):void;
		function set height(value:Number):void;
		function set align(value:String):void;
		function set float(value:String):void;
		function set top(value:Number):void;
		function set right(value:Number):void;
		function set left(value:Number):void;
		function set bottom(value:Number):void;

		
		function getChildAt(index:int):DisplayObject;
		
	}
}