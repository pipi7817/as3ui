package as3ui.utils.io
{
	public class Log
	{
		private static const NONE:uint		= 0;
		private static const ERROR:uint		= 1;
		private static const WARNING:uint	= 2;
		private static const INFO:uint		= 3;
		private static const DEBUG:uint		= 4;
		
		public static var level:uint		= 4;
		
		public function Log()
		{
		}
		
		static public function error(a_message:*):void
		{
			if(level >= ERROR)
			{
				trace("ERROR		| " + a_message);	
			}
		}
		
		static public function warning(a_message:*):void
		{
			if(level >= WARNING)
			{
				trace("WARNING	| " + a_message);	
			}
		}

		static public function info(a_message:*):void
		{
			if(level >= INFO)
			{
				trace("INFO		| " + a_message);	
			}
		}

		static public function debug(a_message:*):void
		{
			if(level >= DEBUG)
			{
				trace("DEBUG		| " + a_message);	
			}
		}
		
	}
}