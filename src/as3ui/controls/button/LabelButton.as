/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.controls.button
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class LabelButton extends BaseButton
	{
		internal var m_upState			:	DisplayObject;
		internal var m_overState		:	DisplayObject;
		internal var m_downState		:	DisplayObject;
		internal var m_hitArea			:	DisplayObject;
		internal var m_label			:	TextField;
		
		protected var m_topPadding		:	int					=	5;
		protected var m_rightPadding	:	int					=	5;
		protected var m_bottomPadding	:	int					=	5;
		protected var m_leftPadding		:	int					=	5;

		public function LabelButton(a_label:TextField,a_upState:DisplayObject,a_overState:DisplayObject = null,a_downState:DisplayObject = null,a_hitArea:DisplayObject = null)
		{
			initialize(a_label,a_upState,a_overState,a_downState,a_hitArea);
		}
		
		public function setPadding(a_top:Number = NaN ,a_right:Number = NaN ,a_bottom:Number = NaN,a_left:Number = NaN):void
		{
			if(!isNaN(a_top)) m_topPadding = a_top;
			if(!isNaN(a_right)) m_rightPadding = a_right;
			if(!isNaN(a_bottom)) m_bottomPadding = a_bottom;
			if(!isNaN(a_left)) m_leftPadding = a_left;
			
			resize();
			
		}
		
		
		private function initialize(a_label:TextField,a_upState:DisplayObject,a_overState:DisplayObject,a_downState:DisplayObject,a_hitArea:DisplayObject):void
		{
			m_upState	= a_upState;
			m_label		= a_label;
			m_overState	= a_overState?a_overState:a_upState;
			m_downState	= a_downState?a_downState:m_overState;
			m_hitArea	= a_hitArea?a_hitArea:a_upState;
			
			m_overState.visible 	= false;
			m_downState.visible 	= false;				
			m_upState.visible 		= true;

			resize();

			addChild(m_upState);
			addChild(m_overState);
			addChild(m_downState);
			addChild(m_hitArea);
			addChild(m_label);

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

		protected function resize():void
		{
			m_upState.width		= Math.round( m_leftPadding + m_label.width + m_rightPadding );
			m_overState.width	= Math.round( m_leftPadding + m_label.width + m_rightPadding );
			m_downState.width	= Math.round( m_leftPadding + m_label.width + m_rightPadding );
			m_hitArea.width		= Math.round( m_leftPadding + m_label.width + m_rightPadding );

			m_upState.height	= Math.round( m_topPadding + m_label.height + m_bottomPadding );
			m_overState.height	= Math.round( m_topPadding + m_label.height + m_bottomPadding );
			m_downState.height	= Math.round( m_topPadding + m_label.height + m_bottomPadding );
			m_hitArea.height	= Math.round( m_topPadding + m_label.height + m_bottomPadding );

			m_label.x = m_leftPadding;
			m_label.y = m_topPadding;
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