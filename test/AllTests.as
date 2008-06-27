package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	import se.konstruktor.as3ui.controls.button.BaseButtonTest;
	import se.konstruktor.as3ui.controls.button.SimpleButtonTest;
	import se.konstruktor.as3ui.controls.scrollbar.BaseScrollBarTest;
	import se.konstruktor.as3ui.managers.FocusManagerTest;
	import se.konstruktor.as3ui.UIObjectTest;
	import se.konstruktor.as3ui.utils.stage.TopLevelTest;
	import se.konstruktor.as3ui.video.BasePlayerTest;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(se.konstruktor.as3ui.controls.button.BaseButtonTest.suite());
			addTest(se.konstruktor.as3ui.controls.button.SimpleButtonTest.suite());
			addTest(se.konstruktor.as3ui.controls.scrollbar.BaseScrollBarTest.suite());
			addTest(se.konstruktor.as3ui.managers.FocusManagerTest.suite());
			addTest(se.konstruktor.as3ui.UIObjectTest.suite());
			addTest(se.konstruktor.as3ui.utils.stage.TopLevelTest.suite());
//			addTest(se.konstruktor.as3ui.video.BasePlayerTest.suite());
		}
	}
}
