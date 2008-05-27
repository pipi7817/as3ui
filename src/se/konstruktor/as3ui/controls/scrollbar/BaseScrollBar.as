/*
* WARNING: Scrollbar is under development dont use. 
*/

package se.konstruktor.as3ui.controls.scrollbar
{
	import se.konstruktor.as3ui.UIObject;
	import se.konstruktor.as3ui.controls.button.ScrollBarEvent;

	public class BaseScrollBar extends UIObject
	{
		private var m_scroll				:	Number;
		private var m_delta					:	Number;

		public function BaseScrollBar()
		{
			super();
			initialize();
		}

		private function initialize():void
		{
			m_scroll = 0;
			m_delta = 0;
//			initializeEvents();
		}

		private function initializeEvents():void
  		{
			m_scrollEvent				= 	new ScrollBarEvent(ScrollBarEvent.SCROLL,true,true);
		}
						
		public function set scroll(a_percent:Number):void
		{
			var oldScroll	:	Boolean	=	m_scroll;
			m_scroll					=	Math.min(1,Math.max(0,a_percent));
			
			if(oldScroll != m_scroll)
			{
				m_delta = oldScroll - m_scroll;
				dispatchEvent(m_scrollEvent);
			}
		}
	
		public function get scroll():Number
		{
			return m_scroll;
		}
		
		public function get delta():Number
		{
			return m_delta;
		}

		private function onScroll():void
		{
			dispatchEvent(m_scrollEvent);
		}
		
	}
}