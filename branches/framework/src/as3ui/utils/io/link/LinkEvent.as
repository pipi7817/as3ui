package as3ui.utils.io.link
{
	import app.view.components.menu.vo.LinkVO;
	
	import flash.events.Event;

	public class LinkEvent extends Event
	{
		
		private var m_data:LinkVO;
		
		public static const CLICK:String = "MenuEventClick";


		public function LinkEvent(a_type:String, a_data:LinkVO, a_bubbles:Boolean=true, a_cancelable:Boolean=true)
		{
			m_data = a_data;
			super(a_type, a_bubbles, a_cancelable);

		}
		
		public function get data():LinkVO
		{
			return m_data;
		}
		
		override public function clone():Event
		{
			return new LinkEvent(type,data,bubbles,cancelable);
		}
	}
}