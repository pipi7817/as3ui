package <%= package_name %> {

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;

	public class <%= test_case_name  %> extends TestCase {
		private var m_instance:<%= class_name %>;

		public function <%= test_case_name %>(methodName:String=null) {
			super(methodName)
		}

		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new <%= test_case_name %>("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void {
			super.setUp();
			m_instance = new <%= class_name %>();
			// addChild(m_instance);
		}

		override protected function tearDown():void {
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void {
			assertTrue("<%= instance_name %> is <%= class_name %>", m_instance is <%= class_name %>);
		}

	}
}