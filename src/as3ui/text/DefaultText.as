package as3ui.text
{
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class DefaultText extends TextField
	{
		public function DefaultText(a_format:TextFormat = null)
		{
			super();

			if(a_format)
			{
				defaultTextFormat = a_format;				
			}

			embedFonts = (a_format != null);
			antiAliasType = AntiAliasType.ADVANCED;
			gridFitType = GridFitType.PIXEL;
			autoSize = TextFieldAutoSize.LEFT;
			multiline = false;
			wordWrap = false;
			border = false;
			selectable = false;
		}
		
		public function get color():uint
		{
			return getTextFormat().color.valueOf();
		}
		
		public function set color(a_color:uint):void
		{
			var tf:TextFormat = getTextFormat();
			tf.color = a_color;
			setTextFormat(tf);
		}
	}
}