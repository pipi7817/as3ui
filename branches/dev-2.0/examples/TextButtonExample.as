package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.bytearray.display.ScaleBitmap;
	
	import as3ui.controls.button.TextButton;
	
	public class TextButtonExample extends Sprite
	{
		
		
		[Embed(source='../src/resources/png/button/ButtonYellow_up.png')]
		private var PNG_UP:Class;

		[Embed(source='../src/resources/png/button/ButtonYellow_over.png')]
		private var PNG_OVER:Class;

		[Embed(source='../src/resources/png/button/ButtonYellow_down.png')]
		private var PNG_DOWN:Class;

		[Embed(systemFont='Arial', fontName="Arial", fontWeight="bold", mimeType="application/x-font-truetype")]
		private var FONT:Class;

		public function TextButtonExample()
		{
			var label:TextField = new TextField();
			label.defaultTextFormat = new TextFormat("Arial",11,0xFFFFFF);
			label.embedFonts = true;
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.text = "» Example text button";
			label.autoSize = TextFieldAutoSize.LEFT;
			
			
			var up:ScaleBitmap		= new ScaleBitmap( (new PNG_UP() as Bitmap).bitmapData);
			var over:ScaleBitmap	= new ScaleBitmap( (new PNG_OVER() as Bitmap).bitmapData);
			var down:ScaleBitmap	= new ScaleBitmap( (new PNG_DOWN() as Bitmap).bitmapData);
			
			up.scale9Grid		= new Rectangle(1,1,up.width-2,up.height-2);
			over.scale9Grid		= new Rectangle(1,1,over.width-2,over.height-2);
			down.scale9Grid		= new Rectangle(1,1,down.width-2,down.height-2);
			
			var button:TextButton = new TextButton(label,up,over,down);

			label.filters = [new DropShadowFilter(0,120,0,0.21,5,5,1)];
			up.filters = [new DropShadowFilter(0,120,0,0.41,5,5,1)];
			over.filters = [new DropShadowFilter(0,120,0,0.41,5,5,1)];
			down.filters = [new DropShadowFilter(0,120,0,0.41,3,3,1)];

			button.setPadding(8,16,8,16);
			addChild(button);	
		}

	}
}