/**
* @author Alexander Aivars <alex(at)kramgo.com>
*/

package as3ui.framework.componentmanager
{
	import as3ui.framework.componentmanager.events.ComponentManagerEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event (name="update", type="as3ui.framework.componentmanager.events")]
	public class ComponentManager extends EventDispatcher
	{
		
		private static const m_instance:ComponentManager = new ComponentManager(SingeltonLock);
		private var m_stage  : Stage;
		
		public function ComponentManager(lock:Class)
		{
			if (lock != SingeltonLock)
			{
				throw new Error("ComponentHandler can only be accessed through ComponentHandler.instance");
			}
		}


		
		private function stageRenderHandler(a_event:Event):void
		{
			dispatchEvent(new ComponentManagerEvent(ComponentManagerEvent.UPDATE,false,false));
		}

		private function initalize(a_stage:Stage):void
		{
        	if(m_stage)
        	{
        		m_stage.removeEventListener(Event.RENDER,stageRenderHandler);
        	}
            
			m_stage = a_stage;
       		m_stage.addEventListener(Event.RENDER,stageRenderHandler,false,0,true);
			
		}
		
		static ns_component_manager function get instance():ComponentManager
		{
			return m_instance;
		}
		
        static ns_component_manager function init(a_stage:Stage):void
        {
			m_instance.initalize(a_stage);
        }
        
        static ns_component_manager function get isInited():Boolean
        {
        	return m_instance.m_stage != null;
        }
        
		static ns_component_manager function addEventListener(a_type:String, a_listener:Function, a_useCapture:Boolean=false, a_priority:int=0, a_useWeakReference:Boolean=true):void
		{
			m_instance.addEventListener(a_type, a_listener, a_useCapture, a_priority, a_useWeakReference)
		}
		
		static ns_component_manager function removeEventListener(a_type:String, a_listener:Function, a_useCapture:Boolean=false):void
		{
			m_instance.removeEventListener(a_type, a_listener, a_useCapture);
		}
        
	}
}

internal class SingeltonLock 
{
}