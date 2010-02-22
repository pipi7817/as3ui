/**
* @author Alexander Aivars <alex(at)kramgo.com>
*/

package as3ui.framework.component
{
	import flash.utils.describeType;
	
	public class BasicComponentInfo
	{
		///////////////////////////////////////////////////////////////////////
		// NAMESPACE
		///////////////////////////////////////////////////////////////////////
	
		///////////////////////////////////////////////////////////////////////
		// MEMBER VARIABLES
		///////////////////////////////////////////////////////////////////////
		private var m_componentId:String;
		private var m_layer:String;
		private var m_depth:int;
		private var m_file:String;
		private var m_data:XML;
		private var m_progressive:Boolean;
		private var m_float:String;
		
		///////////////////////////////////////////////////////////////////////
		// SETTERS AND ACCESSORS
		///////////////////////////////////////////////////////////////////////
		public function get componentId():String { return m_componentId; }
		public function set componentId(value:String):void { m_componentId = value; }

		public function get layer():String { return m_layer; }
		public function set layer(value:String):void { m_layer = value; }

		public function get depth():int { return m_depth; }
		public function set depth(a_value:int):void { m_depth = a_value; }

		public function get float():String { return m_float; }
		public function set float(a_value:String):void { m_float = a_value; }

		public function get file():String { return m_file; }
		public function get data():XML { return m_data; }
		
		ns_component function set file(a_value:String):void { m_file = a_value; }
		ns_component function set data(a_value:XML):void { m_data = a_value; }

		///////////////////////////////////////////////////////////////////////
		// CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////
		public function BasicComponentInfo() {}
		

		///////////////////////////////////////////////////////////////////////
		// PUBLIC INTERFACE
		///////////////////////////////////////////////////////////////////////
		public function parseXML(a_xml:XML):BasicComponentInfo
		{
			for each ( var att:XML in a_xml.attributes() )
			{
				if(hasOwnProperty(att.name()))
				{
					this[att.name().toString()] = att.toString();;
				}
				else if ( att.name() == "id" )
				{
					this["componentId"] = att.toString();
				}
			}
			
			for each ( var item:XML in a_xml.children() )
			{
				if(hasOwnProperty(item.name()))
				{	
					switch( item.name().toString() )
					{
						case "data":
							ns_component::[item.name().toString()] =  XML(item);
						break;
						
						default:
							ns_component::[item.name().toString()] = item.toString();;
						break;
					}
				}
				else if ( item.name() == "id" )
				{
					this["componentId"] = item.toString();
				}
			}			
			
			return this;	
		}
		
		public function toString():String
		{
			var xml:XML = describeType(this);
			var list:XMLList = xml..accessor.( attribute("access") == "readwrite" || attribute("access") == "readonly")
			var key:String;
			var values:Array = [];
			for each( var item:XML in list)
			{
				key = item.attribute("name").toString();
				values.push(key + "=" + this[key]);
			}
			return xml.attribute("name").toString().split("::")[1] + "[ " + values.join(", ") + " ]";
		}
	}
}
