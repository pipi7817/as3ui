package
{
	import as3ui.controls.button.BaseButton;
	import as3ui.controls.button.ButtonEvent;
	import as3ui.controls.button.ButtonState;
	
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class BaseButtonExample extends BaseButton
	{
		private var m_overState:Shape;
		private var m_pressedState:Shape;
		private var m_releasedState:Shape;
		private var m_label:TextField;
		private var m_width:int = 400;
		private var m_height:int = 24;


		[Embed(systemFont='Arial', fontName="Arial", fontWeight="bold", mimeType="application/x-font-truetype")]
		private var FONT:Class;
		
		public function BaseButtonExample()
		{
			super();

			m_isStickyButton = true;
			drawStates();
			setupStates();
			setupListners();
			mouseChildren = false;
		}
		
		private function drawStates():void
		{
			var colors:Array; 
			var alphas:Array = [1,1,1,1];
			var ratios:Array = [0,127,128,255];
			var matrix:Matrix = new Matrix();

  			matrix.createGradientBox(m_width,24,-Math.PI/2,0,0);
  
			colors = [0xB88A00,0xED8421,0xED9848,0xFFB877];
  			m_releasedState = new Shape();
  			m_releasedState.graphics.lineStyle(0.25,0xe16a00,0.85,true);
			m_releasedState.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,matrix)
			m_releasedState.graphics.drawRoundRect(0,0,m_width,m_height,m_height,m_height);
			m_releasedState.graphics.endFill();
			
			colors = [0xF5B800,0xED8421,0xED9848,0xFFB877];
  			m_overState = new Shape();
  			m_overState.graphics.lineStyle(0.25,0xe16a00,0.85,true);
			m_overState.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,matrix)
			m_overState.graphics.drawRoundRect(0,0,m_width,m_height,m_height,m_height);
			m_overState.graphics.endFill();
			
			colors = [0xFF6633,0xED8421,0xED9848,0xFFB877];
  			m_pressedState = new Shape();
  			m_pressedState.graphics.lineStyle(0.25,0xe16a00,0.85,true);
			m_pressedState.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,matrix)
			m_pressedState.graphics.drawRoundRect(0,0,m_width,m_height,m_height,m_height);
			m_pressedState.graphics.endFill();
			
			
			m_label = new TextField();
			m_label.defaultTextFormat = new TextFormat("Arial",18,0xFFFFFF,null,null,null,null,null,TextFormatAlign.CENTER);
			m_label.embedFonts = true;
			m_label.antiAliasType = AntiAliasType.ADVANCED;
			m_label.width = m_width;
			m_label.height = m_height;
		}
		
		private function setupStates():void 
		{
			m_releasedState.visible = true;
			m_overState.visible = false;
			m_pressedState.visible = false;


			addChild(m_releasedState);
			addChild(m_overState);
			addChild(m_pressedState);
			addChild(m_label);
		}

		private function setupListners():void
		{
			addEventListener(ButtonEvent.CHANGE_STATE,onChangeState);
			addEventListener(ButtonEvent.ROLL_OVER,writeCurrentState);
			addEventListener(ButtonEvent.ROLL_OUT,writeCurrentState);
			addEventListener(ButtonEvent.RELEASE_OUTSIDE,writeCurrentState);
			addEventListener(ButtonEvent.RELEASE,writeCurrentState);
			addEventListener(ButtonEvent.PRESS,writeCurrentState);
		}

		private function writeCurrentState(event:ButtonEvent):void
		{
			//  m_label.text = event.type + "_" + state;
		}
		
		
		
		private function onChangeState(event:ButtonEvent):void
		{
						m_label.text = state;
			
			switch (state)
			{
				case ButtonState.OVER:
					m_releasedState.visible = false;
					m_overState.visible 	= true;
					m_pressedState.visible 	= false;				
				break;

				case ButtonState.PRESSED:
					m_releasedState.visible = false;
					m_overState.visible 	= false;
					m_pressedState.visible 	= true;				
				break;

				default:
					m_releasedState.visible = true;
					m_overState.visible 	= false;
					m_pressedState.visible 	= false;				
				break;
			} 


		}

	}
}