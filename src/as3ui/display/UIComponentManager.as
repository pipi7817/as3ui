/**
* @author Alexander Aivars <alexander.aivars(at)gmail.com>
* 
* note:
* THIS IS VERY BETA USE ATT OWN RISK!
*/

package as3ui.display
{
	import as3ui.events.UIEvent;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event (name="render", type="as3ui.events.UIEvent")]
	public class UIComponentManager extends EventDispatcher
	{
		
		private static const m_instance:UIComponentManager = new UIComponentManager(SingeltonLock);
		private var m_stage  : Stage;
		
		public function UIComponentManager(lock:Class)
		{
			if (lock != SingeltonLock)
			{
				throw new Error("ComponentHandler can only be accessed through ComponentHandler.instance");
			}
		}

		public static function get instance():UIComponentManager
		{
			return m_instance;
		}
		
		private function stageRenderHandler(a_event:Event):void
		{
			dispatchEvent(new UIEvent(UIEvent.RENDER,false,false));
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

        static public function init(a_stage:Stage):void
        {
			m_instance.initalize(a_stage);
        }
        
        static public function get isInited():Boolean
        {
        	return m_instance.m_stage != null;
        }
        
		static public function addEventListener(a_type:String, a_listener:Function, a_useCapture:Boolean=false, a_priority:int=0, a_useWeakReference:Boolean=true):void
		{
			m_instance.addEventListener(a_type, a_listener, a_useCapture, a_priority, a_useWeakReference)
		}
		
		static public function removeEventListener(a_type:String, a_listener:Function, a_useCapture:Boolean=false):void
		{
			m_instance.removeEventListener(a_type, a_listener, a_useCapture);
		}
        
	}
}

internal class SingeltonLock 
{
}