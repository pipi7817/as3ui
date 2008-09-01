package as3ui.video.controlbar
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.bytearray.display.ScaleBitmap;
	
	import as3ui.UIObject;
	import as3ui.controls.scrollbar.ScrollBarEvent;
	
	public class SeekBar extends UIObject
	{
		private var m_background:ScaleBitmap;
		private var m_backgroundMask:Shape;

		// player seek position
		private var m_fullness:ScaleBitmap;
		private var m_fullnessMask:Shape;
		private var m_fullnessValue:Number = 0;

		// load progress
		private var m_progress:ScaleBitmap;
		private var m_progressMask:Shape;
		private var m_progressValue:Number = 0;

		private var m_handle:Sprite;
		private var m_handleBar:Sprite;
		private var m_handleBounds:Rectangle;
		
		private var m_currentTime:TextField;
		private var m_totalTime:TextField;
		
		private var m_hitArea:Sprite;
		
		// handle position variables
		private var m_isScrolling:Boolean;
		private var m_seekCache:Number;
		private var m_seek:Number;			

		private static var PADDING:int = 38;
		
		private var m_width:uint;
		
		// graphics 
		[Embed(source='/resources/png/video/controlbar/Background.png')]
		private var BACKGROUND_PNG:Class;

		[Embed(source='/resources/png/video/controlbar/Fullness.png')]
		private var FULLNESS_PNG:Class;

		[Embed(source='/resources/png/video/controlbar/Progress.png')]
		private var PROGRESS_PNG:Class;

		[Embed(source='/resources/png/video/controlbar/Handle.png')]
		private var HANDLE_PNG:Class;

		// Type assets
		[Embed(source="/resources/swf/font/MyriadBold_Time.swf", fontName="Myriad Bold" )]
		private var FONT:Class;

		
		public function SeekBar(width:int)
		{
			super();
			initalize(width)
		}

		private function initalize(width:int):void
		{
			m_background = new ScaleBitmap((new BACKGROUND_PNG() as Bitmap).bitmapData);
			m_progress = new ScaleBitmap((new PROGRESS_PNG() as Bitmap).bitmapData);
			m_fullness = new ScaleBitmap((new FULLNESS_PNG() as Bitmap).bitmapData);
			
			m_background.scale9Grid = new Rectangle(45,0,110,m_progress.height);
			m_fullness.scale9Grid = new Rectangle(45,0,110,m_progress.height);
			m_progress.scale9Grid = new Rectangle(45,0,110,m_progress.height);
			
			
			
			m_backgroundMask = new Shape();
			m_fullnessMask = new Shape();
			m_progressMask = new Shape();

			m_handle = new Sprite();
			m_handle.addChild(new HANDLE_PNG());
			m_handleBar = new Sprite();
			m_handleBounds = new Rectangle();

			m_hitArea = new Sprite();

			m_currentTime = new TextField();
			m_currentTime.defaultTextFormat = new TextFormat("Myriad Bold",11,0xFFFFFF,null,null,null,null,null,TextFormatAlign.RIGHT);
			m_currentTime.antiAliasType = AntiAliasType.ADVANCED;
			m_currentTime.width = 38;
			m_currentTime.height = 13;
			m_currentTime.embedFonts = true;
			m_currentTime.filters = [new DropShadowFilter(1,260,0,1,0,0,0.5)];
			m_currentTime.text = "00:00";
			m_currentTime.alpha = 0.3;


			m_totalTime = new TextField();
			m_totalTime.defaultTextFormat = new TextFormat("Myriad Bold",11,0xFFFFFF,null,null,null,null,null,TextFormatAlign.LEFT);
			m_totalTime.antiAliasType = AntiAliasType.ADVANCED;
			m_totalTime.width = 38;
			m_totalTime.height = 13;
			m_totalTime.embedFonts = true;
			m_totalTime.filters = [new DropShadowFilter(1,260,0,1,0,0,0.5)];
			m_totalTime.text = "00:00";
			m_totalTime.alpha = 0.3;

			m_handleBar.addChild(m_handle);
			
			m_fullness.mask = m_fullnessMask;
			m_progress.mask = m_progressMask;
			m_background.mask = m_backgroundMask;
			
			addChild(m_background);
			addChild(m_backgroundMask);
			addChild(m_progress);
			addChild(m_progressMask);
			addChild(m_fullness);
			addChild(m_fullnessMask);
			addChild(m_hitArea);
			addChild(m_handleBar);
			addChild(m_currentTime);
			addChild(m_totalTime);

			this.width = width;	
			m_handle.addEventListener(MouseEvent.MOUSE_DOWN,onPressHandle);
			m_hitArea.addEventListener(MouseEvent.MOUSE_DOWN,onPressSeekArea);
			
		}

		private function onPressHandle(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP,onReleaseHandle);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMoveHandle);
			m_handle.startDrag(false,m_handleBounds);
			m_isScrolling = true;
			m_seekCache = m_handle.x;
			m_seek = m_seekCache;			
		}

		private function onMoveHandle(event:MouseEvent):void
		{
			var dist:Number;
					
			m_isScrolling = true;
			m_seekCache	= m_seek;
			m_seek	= m_handle.x;
		
			if(m_seek != m_seekCache)
			{
				dist =  m_seek / range;
				dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL,true,true));
			}	
			event.updateAfterEvent();
		}
		
		private function onReleaseHandle(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onReleaseHandle);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMoveHandle);
			m_handle.stopDrag();
			m_isScrolling = false;
			m_seekCache	= m_seek;
			m_seek	= m_handle.x;
		}	

		private function onPressSeekArea(event:MouseEvent):void
		{
			handle =  event.localX / m_hitArea.width;
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL,true,true));			
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

		private function updateMasks():void
		{
			var wProgress:Number = (m_progress.width-PADDING*2)*m_progressValue;
			var wFullness:Number = (m_fullness.width-PADDING*2)*m_fullnessValue;

			if( isNaN(wProgress) )  wProgress = 0;
			if( isNaN(wFullness) )  wFullness = 0;

			var wProgressDiff:Number = Math.max(0,wProgress-wFullness);
			var wTotal:Number = Math.max(wProgress,wFullness);
			var h:Number = m_background.height
			var xPos:Number = PADDING;

			
			m_backgroundMask.graphics.clear();
			m_backgroundMask.graphics.beginFill(0xFF0000,1);
			m_backgroundMask.graphics.drawRect(0,0,xPos,h);
			m_backgroundMask.graphics.drawRect(xPos+wTotal,0,m_background.width-xPos-wTotal,h);
			m_backgroundMask.graphics.endFill();			

			m_fullnessMask.graphics.clear();
			m_fullnessMask.graphics.beginFill(0x00FF00,1);
			m_fullnessMask.graphics.drawRect(xPos,0,wFullness,h);
			m_fullnessMask.graphics.endFill();			

			m_progressMask.graphics.clear();
			m_progressMask.graphics.beginFill(0x0000FF,1);
			m_progressMask.graphics.drawRect(xPos+wFullness,0,wProgressDiff,h);
			m_progressMask.graphics.endFill();			

		}

		private function get range():int
		{
			return m_width-PADDING*2-m_handle.width;
		}

		override public function set width(value:Number):void
		{
			
			var handelValue:Number = m_handle.x / range; 

			
			m_width = Math.round(value);

			m_background.width = m_width;
			m_progress.width = m_width;
			m_fullness.width = m_width;
			
			m_hitArea.x = PADDING;
			m_hitArea.graphics.clear();
			m_hitArea.graphics.beginFill(0x0000FF,0);
			m_hitArea.graphics.drawRect(0,0,m_width-PADDING*2,12);
			m_hitArea.y = Math.round( (m_fullness.height-m_hitArea.height)/2 ); 
			
			m_handleBar.x = PADDING;
			m_handleBar.y = Math.round( (m_fullness.height-m_handle.height)/2 ) - 1; 
			m_handleBounds.width = range;
			
			m_currentTime.y = Math.round( (m_fullness.height-m_currentTime.height -1)/2 );
			m_totalTime.y = m_currentTime.y
			m_totalTime.x = Math.round(m_width - m_totalTime.width);

			fullness = m_fullnessValue;
			progress = m_progressValue;
			handle =  handelValue;

		}
		
		override public function get width():Number
		{
			return  m_width;
		}

		public function set handle(percent:Number):void
		{
			m_handle.x = Math.round(range*percent);
		}

		public function get handle():Number
		{
			return m_handle.x/range;
		}

		public function set totalTime(time:Number):void
		{
			m_totalTime.text = formatTime(time);
			m_totalTime.alpha = 1;
		}
		
		public function set currentTime(time:Number):void
		{
			m_currentTime.text = formatTime(time);
			m_currentTime.alpha = 1;
		}

		public function set fullness(value:Number):void
		{
			if(!m_isScrolling) 
			{
				m_fullnessValue = value;
				handle = value;
			} else {
				m_fullnessValue = m_handle.x / range;
			}

			updateMasks();
		}
		
		public function set progress(value:Number):void
		{
			m_progressValue = value;
			
			updateMasks();
		}

	}
}