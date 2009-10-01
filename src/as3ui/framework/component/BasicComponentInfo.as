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
		private var m_depth:String;
		private var m_file:String;


		///////////////////////////////////////////////////////////////////////
		// SETTERS AND ACCESSORS
		///////////////////////////////////////////////////////////////////////
		public function get componentId():String { return m_componentId; }
		public function set componentId(value:String):void { m_componentId = value; }

		public function get layer():String { return m_layer; }
		public function set layer(value:String):void { m_layer = value; }

		public function get depth():String { return m_depth; }
		public function set depth(value:String):void { m_depth = value; }

		public function get file():String { return m_file; }
		
		ns_component function set file(value:String):void { m_file = value; }

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
					ns_component::[item.name().toString()] = item.toString();;
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
