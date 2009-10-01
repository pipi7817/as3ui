package as3ui.utils.bitmap
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class ImageUtil
	{
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

	}
}