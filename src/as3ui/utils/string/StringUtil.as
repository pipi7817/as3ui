package as3ui.utils.string
{
	public class StringUtil
	{
		public static function searchAndReplace(content:String, search:String, replace:String):String {
			var start:String;
			var end:String;
			var pos:int = content.indexOf(search);
			while (pos >= 0) {
				start = content.substr(0, pos);
				end = content.substr(pos+search.length);
				content = start+replace+end;
				pos = content.indexOf(search, pos+replace.length);
			}
			return content;
		}
		
		public static function isEmpty(a_string:String):Boolean
		{
			if(a_string == null)
			{
				return true;
			}
			else if ( a_string == "" )
			{
				return true
			}
			else
			{
				return false;
			}
			
		}
		
		public static function isNotEmpty(a_string:String):Boolean
		{
			return !isEmpty(a_string);
		}

	}
}
