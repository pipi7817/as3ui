package se.konstruktor.as3ui.video
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.bytearray.display.ScaleBitmap;
	
	import se.konstruktor.as3ui.controls.scrollbar.ScrollBarEvent;
	
//	import se.svt.events.ScrollEvent;
	
//	public class SeekBarView extends Sprite implements IScrollBarView
	public class SeekBar extends Sprite
	{
		private var _background:ScaleBitmap;
		private var _backgroundMask:Shape;

		// player seek position
		private var _fullness:ScaleBitmap;
		private var _fullnessMask:Shape;
		private var _fullnessValue:Number = 0;

		// load progress
		private var _progress:ScaleBitmap;
		private var _progressMask:Shape;
		private var _progressValue:Number = 0;

		private var _handle:Sprite;
		private var _handleBar:Sprite;
		private var _handleBounds:Rectangle;
		
		private var _currentTimeLabel:TextField;
		private var _totalTimeLabel:TextField;
		
		
		private var _seekArea:Sprite;
		
		// handle position variables
		private var _scrolling:Boolean;
		private var _start:Point;
		private var _previous:Point;
		private var _current:Point;			

		
		private static var PADDING:int = 38;
		
		private var _width:uint;
		
		// graphics 
		[Embed(source='../src/resources/png/video/controlbar/Background.png')]
		private var BACKGROUND_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Fullness.png')]
		private var FULLNESS_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Progress.png')]
		private var PROGRESS_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Handle.png')]
		private var HANDLE_PNG:Class;

		// Type assets
		[Embed(source="../src/resources/swf/font/MyriadBold_Time.swf", fontName="Myriad Bold" )]
		private var FONT:Class;

		
		public function SeekBar(width:int)
		{
			super();
			initalize(width)
		}

		private function initalize(width:int):void
		{
			_background = new ScaleBitmap((new BACKGROUND_PNG() as Bitmap).bitmapData);
			_progress = new ScaleBitmap((new PROGRESS_PNG() as Bitmap).bitmapData);
			_fullness = new ScaleBitmap((new FULLNESS_PNG() as Bitmap).bitmapData);
			
			_background.scale9Grid = new Rectangle(45,0,110,_progress.height);
			_fullness.scale9Grid = new Rectangle(45,0,110,_progress.height);
			_progress.scale9Grid = new Rectangle(45,0,110,_progress.height);
			
			
			
			_backgroundMask = new Shape();
			_fullnessMask = new Shape();
			_progressMask = new Shape();

			_handle = new Sprite();
			_handle.addChild(new HANDLE_PNG());
			_handleBar = new Sprite();
			_handleBounds = new Rectangle();

			_seekArea = new Sprite();

			_currentTimeLabel = new TextField();
			_currentTimeLabel.defaultTextFormat = new TextFormat("Myriad Bold",11,0xFFFFFF,null,null,null,null,null,TextFormatAlign.RIGHT);
			_currentTimeLabel.antiAliasType = AntiAliasType.ADVANCED;
			_currentTimeLabel.width = 38;
			_currentTimeLabel.height = 13;
			_currentTimeLabel.embedFonts = true;
			_currentTimeLabel.filters = [new DropShadowFilter(1,260,0,1,0,0,0.5)];
			_currentTimeLabel.text = "00:00";
			_currentTimeLabel.alpha = 0.3;


			_totalTimeLabel = new TextField();
			_totalTimeLabel.defaultTextFormat = new TextFormat("Myriad Bold",11,0xFFFFFF,null,null,null,null,null,TextFormatAlign.LEFT);
			_totalTimeLabel.antiAliasType = AntiAliasType.ADVANCED;
//			_totalTimeLabel.border = true;
			_totalTimeLabel.width = 38;
			_totalTimeLabel.height = 13;
			_totalTimeLabel.embedFonts = true;
			_totalTimeLabel.filters = [new DropShadowFilter(1,260,0,1,0,0,0.5)];
			_totalTimeLabel.text = "00:00";
			_totalTimeLabel.alpha = 0.3;

			_handleBar.addChild(_handle);
			
			_fullness.mask = _fullnessMask;
			_progress.mask = _progressMask;
			_background.mask = _backgroundMask;
			
			addChild(_background);
			addChild(_backgroundMask);
			addChild(_progress);
			addChild(_progressMask);
			addChild(_fullness);
			addChild(_fullnessMask);
			addChild(_seekArea);
			addChild(_handleBar);
			addChild(_currentTimeLabel);
			addChild(_totalTimeLabel);

			this.width = width;	
			_handle.addEventListener(MouseEvent.MOUSE_DOWN,onPressHandle);
			
			_seekArea.addEventListener(MouseEvent.MOUSE_DOWN,onPressSeekArea);
			
		}
		
		private function onPressSeekArea(event:MouseEvent):void
		{
			var dist:Number;
			var delta:Number;	

			dist =  event.localX / _seekArea.width;
			delta = (event.localX - _handle.x) / range;
			// Todo: change to scroll to
//			dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_STOP,dist,delta));			

		}
		
		private function formatTime(time:Number):String
		{
			var minutes:int = Math.floor( time/60 );
			var seconds:int = time%60

			var ret:String
			ret = (minutes<10)?"0"+minutes.toString():minutes.toString();		
			ret += ":";
			ret += (seconds<10)?"0"+seconds.toString():seconds.toString();
			
			return ret;		
			 
		}
		
		public function set totalTime(time:Number):void
		{
			_totalTimeLabel.text = formatTime(time);
			_totalTimeLabel.alpha = 1;
		}
		
		public function set currentTime(time:Number):void
		{
			_currentTimeLabel.text = formatTime(time);
			_currentTimeLabel.alpha = 1;
		}

		public function get fullness():Number
		{
			return _fullnessValue;
		}

		public function set fullness(value:Number):void
		{
			if(!_scrolling) 
			{
				_fullnessValue = value;
				handle = value;
			} else {
				_fullnessValue = _handle.x / range;
			}

			updateMasks();
		}
		
		public function set progress(value:Number):void
		{
			_progressValue = value;
			
			updateMasks();
		}

		private function updateMasks():void
		{
			var wProgress:Number = (_progress.width-PADDING*2)*_progressValue;
			var wFullness:Number = (_fullness.width-PADDING*2)*_fullnessValue;
			var wProgressDiff:Number = Math.max(0,wProgress-wFullness);
			
			var wTotal:Number = Math.max(wProgress,wFullness);
			var h:Number = _background.height
			var xPos:Number = PADDING;
			
			_backgroundMask.graphics.clear();
			_backgroundMask.graphics.beginFill(0xFF0000,1);
			_backgroundMask.graphics.drawRect(0,0,xPos,h);
			_backgroundMask.graphics.drawRect(xPos+wTotal,0,_background.width-xPos-wTotal,h);
			_backgroundMask.graphics.endFill();			

			_fullnessMask.graphics.clear();
			_fullnessMask.graphics.beginFill(0x00FF00,1);
			_fullnessMask.graphics.drawRect(xPos,0,wFullness,h);
			_fullnessMask.graphics.endFill();			

			_progressMask.graphics.clear();
			_progressMask.graphics.beginFill(0x0000FF,1);
			_progressMask.graphics.drawRect(xPos+wFullness,0,wProgressDiff,h);
			_progressMask.graphics.endFill();			

		}

		public function set handle(percent:Number):void
		{
			_handle.x = Math.round(range*percent);
		}

		public function get handle():Number
		{
			return _handle.x/range;
		}

		private function get range():int
		{
			return _width-PADDING*2-_handle.width;
		}

		private function onPressHandle(event:MouseEvent):void
		{
			var dist:Number;
			var delta:Number;
			
			stage.addEventListener(MouseEvent.MOUSE_UP,onReleaseHandle);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMoveHandle);
			_handle.startDrag(false,_handleBounds);

			_scrolling = true;
			_start = new Point(_handle.x,_handle.y);
			_previous = _start;
			_current = _start;			

			dist =  _current.x / range;
			delta = (_current.x - _start.x) / range;
		}

		private function onMoveHandle(event:MouseEvent):void
		{
			var dist:Number;
			var delta:Number;	
					
			_scrolling = true;
			_previous	= _current;
			_current	= new Point(_handle.x,_handle.y);
		
			if(!_current.equals(_previous))
			{
				dist =  _current.x / range;
				delta = (_current.x - _start.x) / range;
				dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL,true,true));			
			}	
			event.updateAfterEvent();
		}
		
		private function onReleaseHandle(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onReleaseHandle);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMoveHandle);

			var dist:Number;
			var delta:Number;	

			_handle.stopDrag();
			_scrolling = false;
			_previous	= _current;
			_current	= new Point(_handle.x,_handle.y);

			dist =  _current.x / range;
			delta = (_current.x - _start.x) / range;
		}	

		override public function set width(value:Number):void
		{
			
			var handelValue:Number = _handle.x / range; 

			
			_width = Math.round(value);

			_background.width = _width;
			_progress.width = _width;
			_fullness.width = _width;
			
			_seekArea.x = PADDING;
			_seekArea.graphics.clear();
			_seekArea.graphics.beginFill(0x0000FF,0);
			_seekArea.graphics.drawRect(0,0,_width-PADDING*2,12);
			_seekArea.y = Math.round( (_fullness.height-_seekArea.height)/2 ); 
			
			_handleBar.x = PADDING;
			_handleBar.y = Math.round( (_fullness.height-_handle.height)/2 ) - 1; 
			_handleBounds.width = range;
			
			_currentTimeLabel.y = Math.round( (_fullness.height-_currentTimeLabel.height -1)/2 );
			_totalTimeLabel.y = _currentTimeLabel.y
			_totalTimeLabel.x = Math.round(_width - _totalTimeLabel.width);

			fullness = _fullnessValue;
			progress = _progressValue;
			handle =  handelValue;

		}
		
		override public function get width():Number
		{
			return  _width;
		}

	}
}