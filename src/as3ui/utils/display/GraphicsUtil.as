package as3ui.utils.display
{
	import flash.display.Graphics;
	
	public class GraphicsUtil
	{
		public function GraphicsUtil()
		{
		}

		/**	
		 * 
		 * original source: http://www.formequalsfunction.com/downloads/drawWedge.as
		 * 
		 * x, y = center point of the wedge.
		 * startAngle = starting angle in degrees.
		 * arc = sweep of the wedge. Negative values draw clockwise.
		 * radius = radius of wedge. If [optional] radiusY is defined, then radius is the x radius.
		 * radiusY = [optional] y radius for wedge.
		 * */
		public static function drawWedge(a_target:Graphics, a_x:Number, a_y:Number, a_startAngle:Number, a_arc:Number, a_radius:Number, a_radiusY:Number = 0):void
		{
			a_target.moveTo(a_x, a_y);

			// if yRadius is 0, yRadius = radius
			if (a_radiusY == 0)
			{
				a_radiusY = a_radius;
			}
	
			// Init vars
			var segAngle:Number, theta:Number, angle:Number, angleMid:Number, segs:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number;
	
			// limit sweep to reasonable numbers
			if (Math.abs(a_arc)>360) {
				a_arc = 360;
			}
	
			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil(Math.abs(a_arc)/45);
	
			// Now calculate the sweep of each segment.
			segAngle = a_arc/segs;
	
			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians.
	
			theta = -(segAngle/180)*Math.PI;
		
			// convert angle startAngle to radians
			angle = -(a_startAngle/180)*Math.PI;
	
			// draw the curve in segments no larger than 45 degrees.
			if (segs>0)
			{
				// draw a line from the center to the start of the curve
				ax = a_x+Math.cos(a_startAngle/180*Math.PI)*a_radius;
				ay = a_y+Math.sin(-a_startAngle/180*Math.PI)*a_radiusY;
				a_target.lineTo(ax, ay);
				// Loop for drawing curve segments
				for (var i:int = 0; i<segs; i++) {
				angle += theta;
				angleMid = angle-(theta/2);
				bx = a_x+Math.cos(angle)*a_radius;
				by = a_y+Math.sin(angle)*a_radiusY;
				cx = a_x+Math.cos(angleMid)*(a_radius/Math.cos(theta/2));
				cy = a_y+Math.sin(angleMid)*(a_radiusY/Math.cos(theta/2));
				a_target.curveTo(cx, cy, bx, by);
			}
				// close the wedge by drawing a line to the center
				a_target.lineTo(a_x, a_y);
			}
		}
	}
}