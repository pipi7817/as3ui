package
{
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 * asasa sas sasas asas
	 */

	import asunit.framework.TestSuite;
	import se.konstruktor.as3ui.controls.button.BaseButtonTest;
	import se.konstruktor.as3ui.flash.UISpriteTest;

	public class AllTests extends TestSuite
	{

		public function AllTests()
		{
			addTest(se.konstruktor.as3ui.controls.button.BaseButtonTest.suite());
			addTest(se.konstruktor.as3ui.flash.UISpriteTest.suite());
		}

	}
}
