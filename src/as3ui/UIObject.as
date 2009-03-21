/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
* @deprecated Not for public use, replaced by as3ui.display.UISprite 
*/
package as3ui
{
	import as3ui.display.UISprite;
	

	[Event (name="resize", type="as3ui.events.UIEvent")]
	[Event (name="move", type="as3ui.events.UIEvent")]
	[Event (name="moveComplete", type="as3ui.events.UIEvent")]
	[Event (name="show", type="as3ui.events.UIEvent")]
	[Event (name="showComplete", type="as3ui.events.UIEvent")]
	[Event (name="hide", type="as3ui.events.UIEvent")]
	[Event (name="hideComplete", type="as3ui.events.UIEvent")]

	[Deprecated("Use as3ui.display.UISprite")]
	public class UIObject extends UISprite 
	{

		public function UIObject()
		{
			super();
		}
		
	}
}