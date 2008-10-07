package as3ui.controls.input {

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;

	public class BaseInputTest extends TestCase {
		private var m_instance:BaseInput;

		public function BaseInputTest(methodName:String=null) {
			super(methodName)
		}

		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
//	 		ts.addTest(new BaseInputTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void {
			super.setUp();
//			m_instance = new BaseInput();
			// addChild(m_instance);
		}

		override protected function tearDown():void {
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void {
			assertTrue("baseInput is BaseInput", m_instance is BaseInput);
		}

	}
}