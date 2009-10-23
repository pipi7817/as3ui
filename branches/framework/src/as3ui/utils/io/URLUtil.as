package as3ui.utils.io
{
	public class URLUtil
	{
		public function URLUtil()
		{
		}
		
		static public function touch(a_url:String):String
		{
			if(Parameters.vars.touch == 0)
			{
				return a_url;	
			}
			else if(a_url.indexOf("?") > 0 )
			{
				var pattern:RegExp = /touch=[0-9]+/;
				if(pattern.test( a_url ) )
				{
					return a_url.replace(pattern,"touch=" + Parameters.vars.touch);
				}
				else
				{
					return a_url + "&touch=" + Parameters.vars.touch;
				}
			}
			else
			{
				return a_url + "?touch=" + Parameters.vars.touch;
			}
		}
	}
}