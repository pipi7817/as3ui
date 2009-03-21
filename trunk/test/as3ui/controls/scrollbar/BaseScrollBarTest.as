package as3ui.controls.scrollbar
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
	 		ts.addTest(new BaseScrollBarTest());
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

		public function testSetScroll():void
		{
			 
			assertEquals(0, m_instance.scroll);
			assertEquals(0, m_instance.delta);

			m_instance.scroll = 0.1;

			assertEquals(0.1, m_instance.scroll);
			assertEquals(0.1, m_instance.delta);

			m_instance.scroll = 0.2;

			assertEquals(0.2, m_instance.scroll);
			assertEquals(0.1, m_instance.delta);

			m_instance.scroll = 0.5;
			assertEquals(0.5, m_instance.scroll);
			assertEquals(0.3, m_instance.delta);

			m_instance.scroll = 0.3;
			assertEquals(0.3, m_instance.scroll);
			assertEquals(-0.2, m_instance.delta);

			m_instance.scroll = 0.3;
			assertEquals(0.3, m_instance.scroll);
			assertEquals(0, m_instance.delta);

		}
		
	}
}