package as3ui.managers
{

	import as3ui.managers.subtitlemanager.Trigger;
	import as3ui.managers.subtitlemanager.events.SubtitleEvent;
	import as3ui.managers.subtitlemanager.events.SubtitleTriggerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	public class SubtitleManager extends EventDispatcher
	{
		private static const m_instance:SubtitleManager = new SubtitleManager(SingeltonLock);
		
		internal var m_root:IEventDispatcher;
		internal var m_data:XML;
		internal var m_triggers:Dictionary;
		internal var m_loaded:Boolean;
		
		public function SubtitleManager(lock:Class)
		{
			if (lock != SingeltonLock)
			{
				throw new Error("SubtitleManager can only be accessed through SubtitleManager.instance.");
			}
		}
		
		static public function get instance():SubtitleManager
		{
			return m_instance;			
		}
		
		static public function loadConfig( a_xml:XML ) : void
		{
			with(m_instance)
			{
				reset();
				m_data = a_xml;
				m_loaded = true;
				addEventListners();
				loadTriggers();
			}
		}
		
		static public function setContext( a_root:IEventDispatcher) : void
		{
			with( m_instance ) 
			{
				if(m_root != null)
				{
					removeEventListners();
				}
				
				m_root = a_root;
			}
		}

		public function destroy() : void
		{
			reset();
			m_data = null;
			m_root = null;
			m_loaded = false;
		}
				
		internal function getTriggerList() : Array
		{
			var triggers:Array = [];

			if(m_data == null ) return [];			
			for each ( var item:XML in m_data..action)
			{
				triggers.push(item.attribute("trigger").toString());
			}
			
			return triggers;
		}
		
		private function reset() : void
		{
			removeEventListners();
			removeTriggerListners();
			m_triggers = null;
		}

		private function removeTriggerListners() : void
		{
			for each ( var trigger:Trigger in m_triggers ) 
			{
				trigger.reset();
				trigger.removeEventListener(SubtitleTriggerEvent.ACTIVATE, onTriggerActivate);
				trigger.removeEventListener(SubtitleTriggerEvent.UPDATE, onTriggerUpdate);
				trigger.removeEventListener(SubtitleTriggerEvent.DEACTIVATE, onTriggerDeactivate);
			}			
		}
		
		private function loadTriggers() : void
		{
			if(m_triggers == null)
			{
				m_triggers = new Dictionary();
			}
			for each ( var item:XML in m_data..action)
			{
				if( m_triggers[item.attribute("trigger")] == null)
				{
					var trigger:Trigger =  new Trigger(item);
					m_triggers[item.attribute("trigger").toString()] = trigger;
				}
			}			
		}
		
		
		private function addEventListners() : void
		{
			if(m_root == null) return;

			var triggers:Array = getTriggerList();
			for ( var i:int; i < triggers.length; i++)
			{
				m_root.addEventListener(triggers[i].toString(),onTrigger);
			}
		}
		
		private function removeEventListners() : void
		{
			if(m_root == null) return;
			
			var triggers:Array = getTriggerList();
			for ( var i:int; i < triggers.length; i++)
			{
				m_root.removeEventListener(triggers[i].toString(),onTrigger);
			}
		}
			
		private function onTrigger(a_event:Event,a_data:Object = null) : void
		{
			var action:XML =  getAction(a_event.type) as XML;
			var trigger:Trigger;
			
			trace( a_event is SubtitleTriggerEvent );
			
			if(a_event is SubtitleTriggerEvent && (a_event as SubtitleTriggerEvent).data != null )
			{
				a_data = (a_event as SubtitleTriggerEvent).data;
			}
			
			switch( action.attribute("type").toString() )
			{
				case "SHOW" :
					removeTriggerListners();
					trigger = m_triggers[action.attribute("trigger").toString()];
					trigger.addEventListener(SubtitleTriggerEvent.ACTIVATE, onTriggerActivate);
					trigger.addEventListener(SubtitleTriggerEvent.UPDATE, onTriggerUpdate);
					trigger.addEventListener(SubtitleTriggerEvent.DEACTIVATE, onTriggerDeactivate);
					if(a_data != null)
					{
						trigger.vars = a_data;
					}

					trigger.play();
				break;

				case "HIDE" :
					removeTriggerListners();
					dispatchEvent( new SubtitleEvent(SubtitleEvent.HIDE) );
				break;
//								
//				case "HIDE" :
//					trigger = m_triggers[action.attribute("trigger").toString()];
//					trigger.addEventListener(Event.ACTIVATE, onActivateClearTrigger);
//					trigger.play();
//				break;
			}		
		}
		
		private function onTriggerActivate( a_event:Event ) :  void
		{
			dispatchEvent( new SubtitleEvent(SubtitleEvent.SHOW,"") );
		}

		private function onTriggerUpdate( a_event:Event ) :  void
		{
			var trigger:Trigger = a_event.target as Trigger;
			dispatchEvent( new SubtitleEvent(SubtitleEvent.SHOW,trigger.text) );
		}

		private function onTriggerDeactivate( a_event:Event ) :  void
		{
			dispatchEvent( new SubtitleEvent(SubtitleEvent.HIDE) );
		}

		internal function getAction(a_trigger:String) : Object
		{
			return m_data..action.(attribute("trigger") == a_trigger )[0];
		}
		
		public static function trigger(a_trigger:String,a_vars:Object) : void
		{
			if(m_instance.m_root.hasEventListener(a_trigger))
			{
				m_instance.onTrigger(new SubtitleTriggerEvent(a_trigger,a_vars));
			}
	
		}
		
	}
}

internal class SingeltonLock 
{
}