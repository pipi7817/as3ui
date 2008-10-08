package as3ui.managers
{
	import as3ui.managers.soundmanager.Trigger;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	
	public class SubtitleManager extends EventDispatcher
	{
		internal var m_root:DisplayObject;
		private var m_data:XML;
		private var m_triggers:Dictionary;
		
		private var m_channel:Dictionary;
		private var m_sound:Dictionary;
		private var m_loaded:Boolean;
		
		public function SubtitleManager(a_root:DisplayObject)
		{
			m_channel = new Dictionary(true);
			m_sound = new Dictionary(true);
			m_root = a_root;
		}
		
		public function loadConfig( a_xml:XML ) : void
		{
			
			trace("loadConfig");
			m_data = a_xml;
			m_loaded = true;
		
			addEventListners();
			loadTriggers();
		}
		
		private function loadTriggers() : void
		{
			if(m_triggers == null)
			{
				m_triggers = new Dictionary();
			}
			
			for each ( var item:XML in m_data..action)
			{
				if( m_triggers[item.linkage.toString()] == null)
				{
					var trigger:Trigger =  new Trigger(item.linkage.toString());
					trigger.volume = parseFloat(item.volume);
					m_triggers[item.linkage.toString()] = trigger;
				}
			}			
		}
		
		
		private function addEventListners() : void
		{
			var triggers:Array = getTriggerList();
			for ( var i:int; i < triggers.length; i++)
			{
				m_root.addEventListener(triggers[i],onTrigger);
			}
		}
		
		private function removeEventListners() : void
		{
			if(!m_loaded) return;
			var triggers:Array = getTriggerList();
			for ( var i:int; i < triggers.length; i++)
			{
				m_root.removeEventListener(triggers[i],onTrigger);
			}
		}
		
		internal function destroy() : void
		{
			removeEventListners();
		}
			
		private function onTrigger(a_event:Event) : void
		{
			var action:XML =  getAction(a_event.type) as XML;
			var trigger:Trigger;
			
			switch( action.attribute("type").toString() )
			{
				case "PLAY" :
					trigger = m_triggers[action.linkage.toString()];
					trigger.play();
				break;
				
				case "STOP" :
					trigger = m_triggers[action.linkage.toString()];
					trigger.stop();
				break;
			}		
		}

		internal function getAction(a_trigger:String) : Object
		{
			return m_data..action.(attribute("trigger") == a_trigger )[0];
		}
		

		public function getTriggerList() : Array
		{
			var triggers:Array = [];

			if(m_data == null ) return [];			
			for each ( var item:XML in m_data..action)
			{
				triggers.push(item.attribute("trigger").toString());
			}
			
			return triggers;
		}
		
		
		

	}
}