package as3ui.utils.io
{
	import com.google.analytics.GATracker;
	
	public class Tracker
	{
		
		private static const m_instance:Tracker = new Tracker(SingeltonLock);
		public static var ga:GATracker;
		
		public function Tracker(lock:Class)
		{
			if (lock != SingeltonLock)
			{
				throw new Error("Tracker can only be accessed through Tracker.instance");
			}
		}

		public static function get instance():Tracker
		{
			return m_instance;
		}

		

        		
	}
}

internal class SingeltonLock 
{
}