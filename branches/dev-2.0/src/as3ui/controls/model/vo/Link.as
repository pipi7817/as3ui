package as3ui.controls.model.vo
{
	public class Link
	{
		private var m_target:String = LinkTarget.FLASH;
		private var m_label:String;
		private var m_url:String;
		private var m_id:String;
		private var m_logid:String;
		
		public function Link( a_label:String, a_url:String, a_target:String = null, a_id:String = null, a_logid:String = "")
		{
			if(a_target != null) 
			{
				m_target = a_target;
			}
			
			if(a_id != null) 
			{
				m_id = a_id;
			}
			else
			{
				m_id = "__random" + ( new Date() ).time.toString() +"_" + (Math.random()*100).toString(); 
			}
			
			m_label = a_label;
			m_url = a_url;
			m_logid = a_logid;
			
		}
		
		public function get label():String
		{
			return m_label;
		}

		public function get url():String
		{
			return m_url;
		}

		public function get target():String
		{
			return m_target;
		}

		public function get id():String
		{
			return m_id;
		}

		public function get logid():String
		{
			return m_logid;
		}
	}
}