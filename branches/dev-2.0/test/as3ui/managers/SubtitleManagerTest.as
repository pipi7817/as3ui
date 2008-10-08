package as3ui.managers
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;

	public class SubtitleManagerTest extends TestCase
	{
		private var m_instance:SubtitleManager;

		public function SubtitleManagerTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new SubtitleManagerTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
//			m_instance = new SubtitleManager();
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
			assertTrue("instance is SubtitleManager", m_instance is SubtitleManager);
		}

	}
}