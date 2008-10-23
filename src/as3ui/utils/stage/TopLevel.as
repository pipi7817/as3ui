/**
* @author Alexander Aivars <alexander.aivars(at)gmail.com>
* 
* Based on com.lessrain.as3lib.utils.stage.TopLevel by Luis Martinez, Less Rain (luis@lessrain.com)
*
* Use TopLevel.getInstance() in the Main Document root class to
* allow global stage access through
* TopLevel.getInstance().stage
*
*/

package as3ui.utils.stage
{
	import flash.display.Stage;
	
	public class TopLevel
	{
		
		private static const m_instance:TopLevel = new TopLevel(SingeltonLock);
		private var m_stage  : Stage;
		
		public function TopLevel(lock:Class)
		{
			if (lock != SingeltonLock)
			{
				throw new Error("TopLevel can only be accessed through TopLevel.getInstance().");
			}
		}

		public static function getInstance():TopLevel
		{
			return m_instance;
		}


        /**
        * @param stage_ Main document stage [example: myRootDocument.stage]
        */
        static public function set stage(a_stage:Stage):void
        {
            m_instance.m_stage = a_stage;
        }
        
        static public function get stage():Stage
        {
            if(m_instance.m_stage!=null) return m_instance.m_stage;
            else return null;
        }
        		
	}
}

internal class SingeltonLock 
{
}