package as3ui.utils.io
{
	import flash.display.LoaderInfo;
	
	final dynamic public class FlashVars
	{
		
		public var config:String = "";
		public var flashId:String = "flashcontent";
		public var viewWidth:int = 720;
		public var viewHeight:int = 540;
		public var touch:int = 0;
		public var debug:int = 0;
		
		public function FlashVars()
		{
		}
		
		public function load(a_loaderinfo:LoaderInfo):void
		{
			// Save flashvars to global paramters
			var keyStr:String;
			var valueStr:String;
			var paramObj:Object = a_loaderinfo.parameters;
			for (keyStr in paramObj) {
			    valueStr = String(paramObj[keyStr]);

				Parameters.vars[keyStr] = valueStr;
			}			
		}
	}
}
