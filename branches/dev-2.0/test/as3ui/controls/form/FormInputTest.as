package as3ui.controls.form {

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import flash.text.TextField;
	
	import as3ui.controls.input.BaseInput;

	public class FormInputTest extends TestCase {
		private var m_instance:FormInput;

		public function FormInputTest(methodName:String=null) {
			super(methodName)
		}

		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
   			ts.addTest(new FormInputTest());
//	 		ts.addTest(new TextInputTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void {
			super.setUp();
			m_instance = new FormInput(new BaseInput( new TextField() ));
			// addChild(m_instance);
		}

		override protected function tearDown():void {
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("textInput is TextInput", m_instance is FormInput);
		}
		
		public function testSetValue():void
		{
			m_instance.value = "value";
			assertEquals("value",m_instance.value);

			m_instance.value = "";
			assertEquals("",m_instance.value);
		}

		public function testValidateEmail():void
		{
			m_instance.value = "name@domain.org";
			assertTrue("name@domain.org is a valid email", m_instance.validateEmail() );		

			m_instance.value = "a@a.aa";
			assertTrue("a@a.aa is a valid email", m_instance.validateEmail() );		

			m_instance.value = "a@it.subdomain.domain.uk.org";
			assertTrue("a@it.subdomain.domain.uk.org", m_instance.validateEmail() );		

			m_instance.value = "name+filter@domain.org";
			assertTrue("name+filter@domain.org is a valid email", m_instance.validateEmail() );		

			m_instance.value = "name+filter@domain";
			assertFalse("name+filter@domain is a invalid email", m_instance.validateEmail() );		

			m_instance.value = "name//filter@domain.com";
			assertFalse("name//filter@domain.com is a invalid email", m_instance.validateEmail() );		

			m_instance.value = "@domain.com";
			assertFalse("@domain.com is a invalid email", m_instance.validateEmail() );		

			m_instance.value = "name@domain@domain.com";
			assertFalse("name@domain@domain.com is a invalid email", m_instance.validateEmail() );		
		}
	}
}