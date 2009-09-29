////////////////////////////////////////////////////////////////////////////////
//
//
//  NOTICE: This is a dummy flex BitmapAsset 
//
//
////////////////////////////////////////////////////////////////////////////////

package mx.core
{

import flash.display.Bitmap;
import flash.display.BitmapData;

public class BitmapAsset extends Bitmap
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param bitmapData The data for the bitmap image. 
     *
     *  @param pixelSnapping Whether or not the bitmap is snapped
     *  to the nearest pixel.
     *
     *  @param smoothing Whether or not the bitmap is smoothed when scaled. 
     */
    public function BitmapAsset(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
    {
        super(bitmapData, pixelSnapping, smoothing);
    }

    public function get measuredHeight():Number
    {
        if (bitmapData)
            return bitmapData.height
        
        return 0;
    }

    public function get measuredWidth():Number
    {
        if (bitmapData)
            return bitmapData.width;
        
        return 0;
    }

    public function move(x:Number, y:Number):void
    {
        this.x = x;
        this.y = y;
    }

    public function setActualSize(newWidth:Number, newHeight:Number):void
    {
        width = newWidth;
        height = newHeight;
    }
}

}
