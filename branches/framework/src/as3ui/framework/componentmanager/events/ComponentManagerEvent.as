/**
* @author Alexander Aivars <alex(at)kramgo.com>
*/

package as3ui.framework.componentmanager.events
{
	import flash.events.Event;
	
	public class ComponentManagerEvent extends Event
	{
		public static const UPDATE				:	String = "ComponentManagerUpdate";
		
		public function ComponentManagerEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new ComponentManagerEvent(type,bubbles, cancelable);
		}
	
	}
}