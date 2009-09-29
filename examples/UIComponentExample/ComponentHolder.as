package UIComponentExample
{
	import as3ui.display.UIComponent;
	import as3ui.events.UIEvent;
	
	import flash.display.DisplayObject;

	public class ComponentHolder extends UIComponent
	{
		private var cnt:int = 0;
		
		public function ComponentHolder()
		{
			super();
			
			addEventListener(UIEvent.RESIZE,componentResizeHandler);
			addEventListener(UIEvent.REDRAW,componentRedrawHandler);
			for ( var i:int=0; i<10; i++)
			{
				addChild( new ComponentItem() ) ;
			}
			setChanged();
		}
		
		private function componentResizeHandler(a_event:UIEvent):void
		{
			setChanged();
		}
		
		private function componentRedrawHandler(a_event:UIEvent):void
		{
			if(a_event.target == this) return;
			trace("ComponentHolder.componentRedrawHandler()" + (a_event.target== this) );
			setChanged();
		}

		override protected function draw():void
		{
			var child:DisplayObject;
			var ypos:int = 0;
			
			cnt++;
			trace("ComponentHolder.draw() : " + cnt);
			for( var i:int=0; i<numChildren; i++)
			{
				child = getChildAt(i);
				child.y = ypos;
				ypos +=  child.height;
			}
		}
	
		
	}
}