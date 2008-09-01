package as3ui.controls.button.rotatebutton
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	import gs.TweenLite;
	import gs.TweenMax;

	public class Cursor extends Sprite
	{
		
		private var m_dot:Shape;
		private var m_left:Shape;
		private var m_right:Shape;
		
		
		public function Cursor()
		{
			super();
			init();
		}
		
		private function init():void
		{
			m_right = new Shape();
			with(m_right.graphics)
			{
				beginFill(0xFFFFFF);
				moveTo(-19,0);
				lineTo(-11,4);
				lineTo(-12,0);
				lineTo(-11,-4);
				endFill();
			}
			
			m_left = new Shape();
			with(m_left.graphics)
			{
				beginFill(0xFFFFFF);
				moveTo(19,0);
				lineTo(11,4);
				lineTo(12,0);
				lineTo(11,-4);
				endFill();
			}
			
			m_dot = new Shape();
			with(m_dot.graphics)
			{
				beginFill(0xFFFFFF);
				drawCircle(0,0,7);
				endFill();
			}			
			
			addChild(m_right);
			addChild(m_dot);
			addChild(m_left);
			
			filters = [ new GlowFilter(0xFFFFFF,0.7,3,3,1.5,3)]
		}
		
		public function active(a_toggle:Boolean) : void
		{
			m_right.visible = a_toggle;
			m_left.visible = a_toggle;
			
			TweenMax.to(m_right,0.25,{alpha:a_toggle?1:0,glowFilter:{ blurX:a_toggle?4:3,blurY:a_toggle?4:3,strength:a_toggle?1:0.7}});
			TweenMax.to(m_left,0.25,{alpha:a_toggle?1:0,glowFilter:{ blurX:a_toggle?4:3,blurY:a_toggle?4:3,strength:a_toggle?1:0.7}});
			
			filters = a_toggle? [ new GlowFilter(0xFFFFFF,1,4,4,1.5,3)] : [ new GlowFilter(0xFFFFFF,0.7,3,3,1.5,3)]
		}
		
		public function pressed(a_toggle:Boolean) : void
		{
			m_right.x = a_toggle?1:0;			
			m_left.x = a_toggle?-1:0;			
		}
		
	}
}