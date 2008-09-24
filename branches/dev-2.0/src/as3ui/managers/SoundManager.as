package as3ui.managers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class SoundManager extends EventDispatcher
	{
		internal var m_root:DisplayObject;
		private var m_data:XML;
		private var m_active:Dictionary;
		private var m_playing:Boolean;
		public function SoundManager(a_root:DisplayObject)
		{
			m_active = new Dictionary(true);
			m_root = a_root;
			m_root.addEventListener("PlayTestSound1",onTrigger);
		}
		
		public function loadConfig( a_xml:XML ) : void
		{
			m_data = a_xml;
		
			addEventListners();
			
		}
		
		private function addEventListners() : void
		{
			var triggers:Array = getTriggerList();
			for ( var i:int; i < triggers.length; i++)
			{
				m_root.addEventListener(triggers[i],onTrigger);
			}
		}
		
		private function onTrigger(a_event:Event) : void
		{
			m_playing = true;
		}
		
		internal function getAction(a_id:String) : Object
		{
			return m_data..action.(attribute("trigger") == a_id );
		}
		
		public function getTriggerList() : Array
		{
			var triggers:Array = [];
			for each ( var item:XML in m_data..action)
			{
				triggers.push(item.attribute("trigger").toString());
			}
			
			return triggers;
		}
		
		public function get isPlaying() : Boolean
		{
			return m_playing;
		}
				

	}
}