/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.video.controlbar
{
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	
	import as3ui.controls.button.BaseButton;
	import as3ui.controls.button.ButtonEvent;
	import as3ui.controls.button.ButtonState;

	public class Button extends BaseButton
	{
		private var m_background:DisplayObject;
		private var m_icon:DisplayObject;
		private var m_highlight:Shape;


		public function Button(a_background:DisplayObject,a_icon:DisplayObject)
		{
			super();

			m_background = a_background;
			m_icon = a_icon;

			setSize(m_background.width, m_background.height);
			
			m_highlight = new Shape();
			m_highlight.graphics.beginFill(0x000000, 1);
			m_highlight.graphics.drawRect(0, 0, 12, 12);
			m_highlight.graphics.endFill();
			m_highlight.blendMode = BlendMode.OVERLAY;
			m_highlight.alpha = 0;
			
			m_highlight.width = width - 1;
			m_highlight.height = height;	

			m_icon.x = Math.round((width - m_icon.width) / 2);
			m_icon.y = Math.round((height - m_icon.height) / 2);
			m_icon.filters = new Array(new DropShadowFilter(-1, 45, 0x000000, .4, 1, 1));
			
			addEventListener(ButtonEvent.CHANGE_STATE,onChangeState);		
			
			addChild(m_background);
			addChild(m_icon);
			addChild(m_highlight);
		}

		private function onChangeState(event:ButtonEvent):void
		{
			switch (state)
			{
				case ButtonState.RELEASED:
					m_highlight.alpha = 0;
					m_highlight.width = width - 2;
				break;

				case ButtonState.OVER:
					m_highlight.alpha = .25;
					m_highlight.width = width - 2;
				break;

				case ButtonState.PRESSED:
					m_highlight.alpha = .5;
					m_highlight.width = width - 1;
				break;

				case ButtonState.DISABLED:
					m_highlight.alpha = .5;
					m_highlight.width = width - 1;
				break;

			} 
		}		
	}
}