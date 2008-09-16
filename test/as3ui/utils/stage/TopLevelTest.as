package as3ui.utils.stage
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import flash.display.Stage;

	public class TopLevelTest extends TestCase
	{
		private var m_instance:TopLevel;

		public function TopLevelTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new TopLevelTest());
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			// m_instance = new TopLevel();
			// addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			// m_instance = null;
		}

		public function testGetInstance():void
		{
			assertTrue("instance is TopLevel", TopLevel.getInstance() is TopLevel);
		}

		public function testSetStageGetStage():void
		{

			var stage:Stage = getContext().stage;
			
			assertEquals(null, TopLevel.stage);

			TopLevel.stage = stage;
			assertEquals(stage, TopLevel.stage);

		}

	}
}