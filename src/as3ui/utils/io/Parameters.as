package as3ui.utils.io
{
	final public class Parameters
	{
		
		private static const m_instance:Parameters = new Parameters(SingeltonLock);
		private var m_vars:FlashVars = new FlashVars();
		public function Parameters(lock:Class)
		{
			if (lock != SingeltonLock)
			{
				throw new Error("Parameters can only be accessed through static methods");
			}
		}

		private static function get instance():Parameters
		{
			return m_instance;
		}

		public static function get vars():FlashVars
		{
			return instance.m_vars;
		}
        		
	}
}

internal class SingeltonLock 
{
}