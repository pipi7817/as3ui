package as3ui.managers.subtitlemanager
{
	import as3ui.managers.subtitlemanager.events.SubtitleTriggerEvent;
	import as3ui.managers.subtitlemanager.vo.Text;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	[Event (name="activate", type="as3ui.managers.subtitlemanager.events.SubtitleTriggerEvent")]
	[Event (name="deactivate", type="as3ui.managers.subtitlemanager.events.SubtitleTriggerEvent")]
	[Event (name="update", type="as3ui.managers.subtitlemanager.events.SubtitleTriggerEvent")]
	
	public class Trigger extends EventDispatcher
	{
//		private var m_delayTime:Number;
//		private var m_timeoutTime:Number;
//		private var m_text:String;
//		private var m_delay:Timer;
//		private var m_timout:Timer;
		private var m_playing:Boolean;
		private var m_active:Boolean; 
		
		
		private var m_queue:Array;
		private var m_data:Text;
		private var m_timer:Timer;
		internal var m_content:Array;
		
		public var vars:Object;
		
		
		public function Trigger(a_xml:XML)
		{
			m_content = [];
			
			var text:Text;
			m_timer = new Timer(0,1);
			
			for each (var node:XML in a_xml.children())
			{
				text = new Text();
				text.data = node.toString();
				text.delay = parseInt( node.attribute("delay") );
				text.timeout = parseInt( node.attribute("timeout") );
				text.position = node.attribute("position").toString();
				if(text.position != "top" && text.position != "bottom")
				{
					text.position = "bottom";
				}
				
				m_content.push(text);
			} 
			
			
		}
		
		public function get text() : String
		{
			if(vars != null && m_data != null)
			{
				var str:String = m_data.data;
				var pattern:RegExp;
				
				for (var name:* in vars)
				{
					pattern = new RegExp( "{" + name.toString() + "}","g" ) ;
					str = str.replace(pattern,vars[name].toString());
				}				
				
				return str;
				
			}
			else
			{
				return (m_data != null)?m_data.data : "";
			}
		}
		
		public function reset(a_event:Event = null) : void
		{
			m_timer.stop();
			m_timer = new Timer(0,1);
			m_queue = null;
			m_data = null;
			m_playing = false;
			m_active = false;
			vars = null;
		}

		public function play() : void
		{
			if(m_playing)
			{
				reset();	
			}
			m_playing = true;
			cloneContent();
			activate();
			playQueue();
		}
		
		private function playQueue(a_event:Event = null) : void
		{
			if(a_event != null)
			{
				a_event.target.removeEventListener(a_event.type, arguments.callee);
			}

			if(m_queue == null || m_queue.length == 0)
			{
				deactivate();
			}
			else 
			{
				var item:Text = m_queue.shift() as Text;
				m_data = item;
				if( (m_data).delay > 0)
				{
					delayQueueItem();
				}
				else
				{
					showQueueItem();
				}
			}
		}	
		
		private function delayQueueItem() : void
		{
			try
			{
				m_timer.reset();
				m_timer.delay = m_data.delay;
				m_timer.addEventListener(TimerEvent.TIMER_COMPLETE,showQueueItem,false,0,true);
				m_timer.start();
			} 
			catch ( error:RangeError )
			{
				showQueueItem();
			}
		}

		private function showQueueItem(a_event:Event = null) : void
		{
			if(a_event != null)
			{
				a_event.target.removeEventListener(a_event.type, arguments.callee);
			}

			dispatchEvent(new SubtitleTriggerEvent(SubtitleTriggerEvent.UPDATE));

			try
			{
				m_timer.reset();
				m_timer.delay = m_data.timeout;
				m_timer.addEventListener(TimerEvent.TIMER_COMPLETE,playQueue,false,0,true);
				m_timer.start();
			} 
			catch ( error:RangeError )
			{
				playQueue();
			}
		}
		
		private function activate() : void
		{
			if(!m_active)
			{
				m_active = true;
				dispatchEvent(new SubtitleTriggerEvent(SubtitleTriggerEvent.ACTIVATE));
			}			
		}

		private function deactivate() : void
		{
			reset();
			dispatchEvent(new SubtitleTriggerEvent(SubtitleTriggerEvent.DEACTIVATE));
		}

		private function cloneContent() : void
		{
			m_queue = [];
			
			for( var i:int; i<m_content.length; i++)
			{
				m_queue.push(m_content[i]);
			}
		}

		override public function toString() : String
		{
			return "[Trigger "+m_content+"]";
		}
	}
}