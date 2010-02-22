package as3ui.framework.layoutmanager {
	import as3ui.framework.component.BasicComponent;
	
	import flash.display.DisplayObjectContainer;
	
	
	public class DisplayLayer {
		
		private var m_layers:Array;
		private var m_container:DisplayObjectContainer;
		public function DisplayLayer(a_container:DisplayObjectContainer)
		{
			m_layers = [];
			m_container = a_container;
		} 
		
		private function compareDepth(a_first:BasicComponent,a_second:BasicComponent):int
		{
			if( a_first.componentInfo.depth > a_second.componentInfo.depth)
			{
				return 1;
			}
			else if( a_first.componentInfo.depth < a_second.componentInfo.depth)
			{
				return -1;
			}
			else
			{
				return 0;	
			}
		}
		
		private function sort():void
		{
			m_layers.sort(compareDepth);	
			for each ( var child:BasicComponent in m_layers)
			{
				m_container.addChild(child);
			}
		}
		
		public function add(a_comp:BasicComponent):void
		{
			m_layers.push(a_comp);
			sort();
		}
				
		public function get layers():Array
		{
			return m_layers
		}
	}
}
