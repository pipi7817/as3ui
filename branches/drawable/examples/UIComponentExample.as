package
{
	import UIComponentExample.ComponentHolder;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class UIComponentExample extends Sprite
	{
		public function UIComponentExample()
		{
			super();
			var holder:ComponentHolder = new ComponentHolder();
			addChild(holder);
		}
		
	}
}