package as3ui.utils.display
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
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
		
		
		/**	
		 * 
		 * original source: http://www.formequalsfunction.com/downloads/drawArc.as
		 * 
		 * x, y = This must be the current pen position... other values will look bad
		 * radius = radius of Arc. If [optional] yRadius is defined, then r is the x radius
		 * arc = sweep of the arc. Negative values draw clockwise.
		 * startAngle = starting angle in degrees.
		 * yRadius = [optional] y radius of arc.
		 * */
		 public static function drawArc(a_target:Graphics, a_x:Number, a_y:Number, a_startAngle:Number, a_arc:Number, a_radius:Number, a_radiusY:Number = 0):Point
		 {
			// if yRadius is 0, yRadius = radius
			if (a_radiusY == 0)
			{
				a_radiusY = a_radius;
			}
			
			// Init vars
			var segAngle:Number, theta:Number, angle:Number, angleMid:Number, segs:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number;

			// no sense in drawing more than is needed :)
			if (Math.abs(a_arc)>360) {
				a_arc = 360;
			}

			// Flash uses 8 segments per circle, to match that, we draw in a maximum
			// of 45 degree segments. First we calculate how many segments are needed
			// for our arc.
			segs = Math.ceil(Math.abs(a_arc)/45);

			// Now calculate the sweep of each segment
			segAngle = a_arc/segs;

			// The math requires radians rather than degrees. To convert from degrees
			// use the formula (degrees/180)*Math.PI to get radians. 
			theta = -(segAngle/180)*Math.PI;

			// convert angle startAngle to radians
			angle = -(a_startAngle/180)*Math.PI;

			// find our starting points (ax,ay) relative to the secified x,y
			ax = a_x-Math.cos(angle)*a_radius;
			ay = a_y-Math.sin(angle)*a_radiusY;

			// if our arc is larger than 45 degrees, draw as 45 degree segments
			// so that we match Flash's native circle routines.
			if (segs>0) {
				// Loop for drawing arc segments
				for (var i:int = 0; i<segs; i++) {
					// increment our angle
					angle += theta;
					// find the angle halfway between the last angle and the new
					angleMid = angle-(theta/2);
					// calculate our end point
					bx = ax+Math.cos(angle)*a_radius;
					by = ay+Math.sin(angle)*a_radiusY;
					// calculate our control point
					cx = ax+Math.cos(angleMid)*(a_radius/Math.cos(theta/2));
					cy = ay+Math.sin(angleMid)*(a_radiusY/Math.cos(theta/2));
					// draw the arc segment
					a_target.curveTo(cx, cy, bx, by);
				}
			}
			
			// In the native draw methods the user must specify the end point
			// which means that they always know where they are ending at, but
			// here the endpoint is unknown unless the user calculates it on their 
			// own. Lets be nice and let save them the hassle by passing it back. 
			return new Point(bx, by);
		 }
		 
		 
		/**	
		 * 
		 * original source: http://www.formequalsfunction.com/downloads/dashTo.as
		 *
		 * startx, starty = beginning of dashed line
		 * endx, endy = end of dashed line
		 * len = length of dash
		 * gap = length of gap between dashes
		 * */
		
		public static function dashTo(a_target:Graphics, start:Point, end:Point, a_len:Number, a_gap:Number = 5):void
		{

			if(a_len == 0)
			{
				a_target.moveTo(end.x,end.y);
				return;
			}
			
			// init vars
			var seglength:Number, delta:Number, radians:Number, deltax:Number, deltay:Number, segs:Number, cx:Number, cy:Number;
	
			// calculate the legnth of a segment
			seglength = a_len + a_gap;
	
			// calculate the length of the dashed line
			deltax = end.x - start.x;
			deltay = end.y - start.y;
			delta = Math.sqrt((deltax * deltax) + (deltay * deltay));
	
			// calculate the number of segments needed
			segs = Math.floor(Math.abs(delta / seglength));
	
			// get the angle of the line in radians
			radians = Math.atan2(deltay,deltax);
	
			// start the line here
			cx = start.x;
			cy = start.y;
	
			// add these to cx, cy to get next seg start
			deltax = Math.cos(radians)*seglength;
			deltay = Math.sin(radians)*seglength;
	
			// loop through each seg
			for (var n:int = 0; n < segs; n++) {
				a_target.moveTo(cx,cy);
				a_target.lineTo(cx+Math.cos(radians)*a_len,cy+Math.sin(radians)*a_len);
				cx += deltax;
				cy += deltay;
			}
			
			// handle last segment as it is likely to be partial
			a_target.moveTo(cx,cy);
			delta = Math.sqrt((end.x-cx)*(end.x-cx)+(end.y-cy)*(end.y-cy));
			
			if(delta>a_len)
			{
				// segment ends in the gap, so draw a full dash
				a_target.lineTo(cx+Math.cos(radians)*a_len,cy+Math.sin(radians)*a_len);
			}
			else if(delta>0)
			{
				// segment is shorter than dash so only draw what is needed
				a_target.lineTo(cx+Math.cos(radians)*delta,cy+Math.sin(radians)*delta);
			}
			// move the pen to the end position
			a_target.moveTo(end.x,end.y);
		}
		 
	}
}