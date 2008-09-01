package as3ui.controls.button
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class SimpleButton extends BaseButton
	{
		internal var m_upState	:	DisplayObject;
		internal var m_overState	:	DisplayObject;
		internal var m_downState	:	DisplayObject;
		internal var m_hitArea	:	DisplayObject;
		
		public function SimpleButton(a_upState:DisplayObject,a_overState:DisplayObject = null,a_downState:DisplayObject = null,a_hitArea:DisplayObject = null)
		{
			initialize(a_upState,a_overState,a_downState,a_hitArea);
		}
		
		private function initialize(a_upState:DisplayObject,a_overState:DisplayObject,a_downState:DisplayObject,a_hitArea:DisplayObject):void
		{
			m_upState	= a_upState;
			m_overState	= a_overState?a_overState:a_upState;
			m_downState	= a_downState?a_downState:m_overState;
			m_hitArea	= a_hitArea?a_hitArea:a_upState;
			
			m_overState.visible 	= false;
			m_downState.visible 	= false;				
			m_upState.visible 		= true;

			addChild(m_upState);
			addChild(m_overState);
			addChild(m_downState);
			addChild(m_hitArea);

			if(m_hitArea is Sprite)
			{
				hitArea = m_hitArea as Sprite; 
			}
			
			mouseChildren = false;
			
			addEventListners();
		}
		
		private function addEventListners():void
		{
			addEventListener(ButtonEvent.CHANGE_STATE,onChangeState);
		}

		protected function onChangeState(event:ButtonEvent):void
		{
			switch (state)
			{
				case ButtonState.OVER:
					m_upState.visible 		= false;
					m_downState.visible 	= false;				
					m_overState.visible 	= true;
				break;

				case ButtonState.PRESSED:
					m_upState.visible 		= false;
					m_overState.visible 	= false;
					m_downState.visible 	= true;				
				break;

				default:
					m_overState.visible 	= false;
					m_downState.visible 	= false;				
					m_upState.visible 		= true;
				break;
			} 
		}
	}
}