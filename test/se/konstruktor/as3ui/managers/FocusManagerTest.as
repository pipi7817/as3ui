package se.konstruktor.as3ui.managers
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;

	public class FocusManagerTest extends TestCase
	{
		private var m_instance:FocusManager;

		public function FocusManagerTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new FocusManagerTest());
//	 		ts.addTest(new FocusManagerTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new FocusManager();
			// addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("instance is FocusManager", m_instance is FocusManager);
		}

		public function testSortFocusList():void
		{
			
			var shuffel:Function = function(a:Number,b:Number):Number {
				var num : Number = Math.round(Math.random()*2)-1;
				return num;
			}

			m_instance.add(new FocusObject(),"B","a") ;
			m_instance.add(new FocusObject(),"C","a") ;
			m_instance.add(new FocusObject(),"D","b") ;
			m_instance.add(new FocusObject(),"E","b") ;
			m_instance.add(new FocusObject(),"F","c") ;
			m_instance.add(new FocusObject(),"G","9c") ;
			m_instance.add(new FocusObject(),"A","1a") ;
			
			trace(m_instance.m_focusList.join("\n") + "\n");

			m_instance.m_focusList.sort(shuffel);
			
			trace(m_instance.m_focusList.join("\n") + "\n");

			m_instance.sortList();
			
			trace(m_instance.m_focusList.join("\n") + "\n");

		}

	}
}