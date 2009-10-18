package as3ui.utils.bitmap
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class ImageUtil
	{
	
		/**
		 * scaleMode
		 */
		static public const EXACT_FIT:String = StageScaleMode.EXACT_FIT;
		static public const SHOW_ALL:String  = StageScaleMode.SHOW_ALL;
		static public const NO_BORDER:String = StageScaleMode.NO_BORDER;
		static public const NO_SCALE:String  = StageScaleMode.NO_SCALE;
		
		/**
		 * align
		 */
		static public const TOP_LEFT:String     = StageAlign.TOP_LEFT;
		static public const TOP:String          = StageAlign.TOP;
		static public const TOP_RIGHT:String    = StageAlign.TOP_RIGHT;
		static public const LEFT:String         = StageAlign.LEFT;
		static public const CENTER:String       = "";
		static public const RIGHT:String        = StageAlign.RIGHT;
		static public const BOTTOM_LEFT:String  = StageAlign.BOTTOM_LEFT;
		static public const BOTTOM:String       = StageAlign.BOTTOM;
		static public const BOTTOM_RIGHT:String = StageAlign.BOTTOM_RIGHT;
	
		public function ImageUtil()
		{
		}
		
		static public function rotateBitmapData(a_source:BitmapData):BitmapData
		{
			var transformation:Matrix =new Matrix();
			transformation.rotate(Math.PI);
			transformation.tx = a_source.width;
			transformation.ty = a_source.height;
			
			var copy:BitmapData = a_source.clone();
			
			a_source.lock();
			a_source.draw(copy, transformation);
			a_source.unlock();
			
			copy.dispose();
			copy = null;
			return a_source;
		}
		
/*
			var boundary:Rectangle = _border.getRect(this);
			var target:Rectangle   = _picture.bitmapData.rect;
			
			//IMPORTANT HERE--------------------------
			var resized:Rectangle = BoundaryResizer.resize(target, boundary, _scaleMode, _align);
			//----------------------------------------
			
			_picture.x      = resized.x;
			_picture.y      = resized.y;
			_picture.width  = resized.width;
			_picture.height = resized.height;
*/
		
		static public function resize(target:Rectangle, boundary:Rectangle, scaleMode:String = "noScale", align:String = ""):Rectangle
		{
			var tx:Number = target.x,
			    ty:Number = target.y,
			    tw:Number = target.width,
			    th:Number = target.height,
			    bx:Number = boundary.x,
			    by:Number = boundary.y,
			    bw:Number = boundary.width,
			    bh:Number = boundary.height,
			    rx:Number,
				ry:Number,
				rw:Number,
				rh:Number;
			
			switch (scaleMode)
			{
				case SHOW_ALL:
				case NO_BORDER:
					var ratioW:Number = bw / tw,
					    ratioH:Number = bh / th,
					    ratio:Number  = (scaleMode == SHOW_ALL) ? ( (ratioW < ratioH) ? ratioW : ratioH ) : 
					                                              ( (ratioW > ratioH) ? ratioW : ratioH ) ;
					rw = ratio * tw;
					rh = ratio * th;
					break;
				
				case EXACT_FIT:
					return new Rectangle(bx, by, bw, bh);
				
				default:
					rw = tw;
					rh = th;
					break;
			}
			
			rx = bx + ( (align == TOP_LEFT    || align == LEFT   || align == BOTTOM_LEFT ) ? 0               :
			            (align == TOP_RIGHT   || align == RIGHT  || align == BOTTOM_RIGHT) ? (bw - rw)       :
			                                                                                 (bw - rw) / 2 ) ;
			ry = by + ( (align == TOP_LEFT    || align == TOP    || align == TOP_RIGHT   ) ? 0               :
			            (align == BOTTOM_LEFT || align == BOTTOM || align == BOTTOM_RIGHT) ? (bh - rh)       :
			                                                                                 (bh - rh) / 2 ) ;
			
			return new Rectangle(rx, ry, rw, rh);		
		}
	
	}
}