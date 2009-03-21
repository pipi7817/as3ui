/*
* WARNING: Scrollbar is under development dont use. 
*/

/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.controls.scrollbar
{
	import as3ui.UIObject;

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


						
		public function set scroll(a_percent:Number):void
		{
			var oldScroll	:	Number	=	m_scroll;
			m_scroll					=	Math.min(1,Math.max(0,a_percent));
			
//			if(oldScroll != m_scroll)
//			{
				m_delta = m_scroll - oldScroll;
				dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL,true,true));
//			}
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

		}
		
	}
}