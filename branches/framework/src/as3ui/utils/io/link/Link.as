package as3ui.utils.io.link
{
	
	public class Link
	{

		private var m_label:String;
		private var m_style:Object = new Object();
		private var m_target:String;
		private var m_href:String;
		private var m_uri:String;
		
		
		// public function Link( a_label:String, a_url:String, a_target:String = null, a_id:String = null, a_logid:String = "")
		
		
		public function Link(a_data:Object)
		{
			
			if(a_data is XML)
			{
				m_href = a_data.attribute("href").toString();
				m_target = a_data.attribute("target").toString().toLowerCase();
				if(m_target.length<1)
				{
					m_target = LinkTarget.FLASH;
				}

				for each ( var attr:String in a_data.attribute("style").toString().match( /(\w+:\w+)/g ) )
				{
					m_style[attr.split(":")[0]] = cast( attr.split(":")[1] );
				}
				m_uri = a_data.attribute("uri").toString();
			}
			else
			{
				throw Error( " Class Link Parameter Object not implemented " ); 
			}
		}
		
		private function cast(a_str:String):*
		{
			
			if(a_str == "true")
			{
				return true;
			}
			else if(a_str == "false")
			{
				return false;	
			}			
			else if(parseFloat(a_str) != isNaN())
			{
				return parseFloat(a_str);
			}
			else
			{
				return a_str;
			}
		}
		
		public function get href():String
		{
			return m_href;
		}

		public function get target():String
		{
			return m_target;
		}
		
		public function get style():Object
		{
			return m_style;
		}
		
		public function get label():String
		{
			return m_label;
		}
		
		public function get uri():String
		{
			return m_uri;
		}
		
		public function toString():String
		{
			return "LinkVO[label:"+label+",target:"+target+",href:"+href+"]";
		}
	}
}