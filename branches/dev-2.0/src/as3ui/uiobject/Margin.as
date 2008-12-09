package as3ui.uiobject
{
	public class Margin
	{
		private var m_top:Number;
		private var m_right:Number;
		private var m_bottom:Number;
		private var m_left:Number;
		
		public function Margin(a_top:Number=0,a_right:Number=0,a_bottom:Number=0,a_left:Number=0)
		{
			top = a_top;
			right = a_right;
			bottom = a_bottom;
			left = a_left;
		}
		
		public function get top():Number	{ return m_top; }
		public function get right():Number	{ return m_right; }
		public function get bottom():Number { return m_bottom; }
		public function get left():Number	{ return m_left; }

		public function set top(a_value:Number):void	{ m_top = a_value; }
		public function set right(a_value:Number):void	{ m_right = a_value; }
		public function set bottom(a_value:Number):void { m_bottom = a_value; }
		public function set left(a_value:Number):void	{ m_left = a_value; }

		public function toString():String { return "["+top+","+right+","+bottom+","+left+"]"; }
	}
}