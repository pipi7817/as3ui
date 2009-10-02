package as3ui.framework.layoutmanager
{
	import as3ui.framework.component.BasicComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class LayoutManager
	{
		private var m_layer:Dictionary;
		
		public function LayoutManager()
		{
			initalize();
		}

		private function initalize():void
		{
			m_layer = new Dictionary();
			
		}
		
		private function getLayer(a_id:String):DisplayObjectContainer
		{
			if( m_layer[a_id] )
			{
				return m_layer[a_id];
			} 
			else
			{
				m_layer[a_id] = new Sprite();
				return m_layer[a_id];
			}
		}	
		
		public function addComponent(a_component:BasicComponent):void
		{
			var layer:DisplayObjectContainer = getLayer( a_component.componentInfo.layer )
			layer.addChild(a_component);
		}
		
		public function get layers():Array
		{
			var ret:Array = [];
			for each (var value:Object in m_layer)
			{
				ret.push(value);
			}
			
			return ret;
		}
	}
}