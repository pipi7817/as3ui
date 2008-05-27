package se.konstruktor.as3ui.controls.scrollbar
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;

	public class BaseScrollBarTest extends TestCase
	{
		private var m_instance:BaseScrollBar;

		public function BaseScrollBarTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new BaseScrollBarTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new BaseScrollBar();
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
			assertTrue("instance is BaseScrollBar", m_instance is BaseScrollBar);
		}

	}
}