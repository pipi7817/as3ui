/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.controls.input
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	import org.bytearray.display.ScaleBitmap;
	
	public class RoundTextInput extends BaseInput
	{
		private var m_background:DisplayObject;

		[Embed(source='/resources/png/input/InputGrey_background.png')]
		private var BACKGROUND_PNG:Class;

		[Embed(systemFont='Arial', fontName="Arial", fontWeight="bold", mimeType="application/x-font-truetype")]
		private var FONT:Class;
		
		public function RoundTextInput()
		{
			m_background = new ScaleBitmap( (new BACKGROUND_PNG() as Bitmap).bitmapData );
			m_background.scale9Grid = new Rectangle(m_background.width/4,(m_background.height/2)-1,m_background.width/2,2);
			addChild(m_background);
			m_background.width = 100;
			m_background.height = 24;
			
			super(new TextField());
			
			m_inputField.antiAliasType = AntiAliasType.ADVANCED;
			m_inputField.defaultTextFormat = new TextFormat("Arial",12);
			
			m_inputField.embedFonts = true;
			m_inputField.border = false;
			m_inputField.type = TextFieldType.INPUT;
			m_inputField.text = "";
			m_inputField.wordWrap = false;
			m_inputField.multiline = false;
			var metrics:TextLineMetrics = m_inputField.getLineMetrics(0);

			m_inputField.autoSize = TextFieldAutoSize.NONE;
			
			m_inputField.y = Math.round( (m_background.height-metrics.height)/2 -2);
			m_inputField.width = m_background.width - 20;
			m_inputField.x = 10;
			m_inputField.height = m_background.height;


		}

		override protected function onFoucusIn(event:FocusEvent):void
		{
			filters = [new GlowFilter(0x86c6e1) ];
		}

		override protected function onFoucusOut(event:FocusEvent):void
		{
			filters = [];
		}
				
	}
}