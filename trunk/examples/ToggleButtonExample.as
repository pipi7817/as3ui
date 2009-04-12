package
{
	import as3ui.controls.button.ButtonEvent;
	import as3ui.controls.button.SimpleButton;
	
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	public class ToggleButtonExample extends Sprite
	{
		
		
		[Embed(source='../src/resources/png/button/control/ControlButtonYellow_up.png')]
		private var PNG_UP:Class;

		[Embed(source='../src/resources/png/button/control/ControlButtonYellow_over.png')]
		private var PNG_OVER:Class;

		[Embed(source='../src/resources/png/button/control/ControlButtonYellow_down.png')]
		private var PNG_DOWN:Class;

		private var btn1:SimpleButton;
		private var btn2:SimpleButton;
		private var btn3:SimpleButton;
		
		private var m_active:SimpleButton;
		
		public function ToggleButtonExample()
		{
			
			btn1 = new SimpleButton(new PNG_UP(),new PNG_OVER(), new PNG_DOWN() );
			btn1.filters = [new DropShadowFilter(0,120,0,0.21,5,5,1)];
			
			btn2 = new SimpleButton(new PNG_UP(),new PNG_OVER(), new PNG_DOWN() );
			btn2.filters = [new DropShadowFilter(0,120,0,0.21,5,5,1)];

			btn3 = new SimpleButton(new PNG_UP(),new PNG_OVER(), new PNG_DOWN() );
			btn3.filters = [new DropShadowFilter(0,120,0,0.21,5,5,1)];

			btn1.isToggleButton = true;
			btn2.isToggleButton = true;
			btn3.isToggleButton = true;

			btn1.x = 0;
			btn2.x = 80;
			btn3.x = 160;

			addChild(btn1);
			addChild(btn2);
			addChild(btn3);
			
			addEventListener(ButtonEvent.TOGGLE,onToggleButton);

		}
		
		private function onToggleButton(a_event:ButtonEvent):void
		{
			var btn:SimpleButton = a_event.target as SimpleButton;
			
			if(m_active != null && m_active != btn)
			{
				m_active.toggled = false;
				
			}
			

			m_active = btn;
			
		}
		
	}
}