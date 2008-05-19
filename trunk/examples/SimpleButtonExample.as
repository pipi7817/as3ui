package
{
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	import se.konstruktor.as3ui.controls.button.SimpleButton;
	
	public class SimpleButtonExample extends Sprite
	{
		
		
		[Embed(source='../src/resources/png/button/control/ControlButtonYellow_up.png')]
		private var PNG_UP:Class;

		[Embed(source='../src/resources/png/button/control/ControlButtonYellow_over.png')]
		private var PNG_OVER:Class;

		[Embed(source='../src/resources/png/button/control/ControlButtonYellow_down.png')]
		private var PNG_DOWN:Class;

		public function SimpleButtonExample()
		{
			
			var button:SimpleButton = new SimpleButton(new PNG_UP(),new PNG_OVER(), new PNG_DOWN() );
			button.filters = [new DropShadowFilter(0,120,0,0.21,5,5,1)];
			addChild(button);	
		}

	}
}