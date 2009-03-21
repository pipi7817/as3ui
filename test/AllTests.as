package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	import as3ui.controls.button.BaseButtonTest;
	import as3ui.controls.button.SimpleButtonTest;
	import as3ui.controls.scrollbar.BaseScrollBarTest;
	import as3ui.UIObjectTest;
	import as3ui.utils.stage.TopLevelTest;
	import as3ui.video.MediaTest;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new as3ui.controls.button.BaseButtonTest());
			addTest(new as3ui.controls.button.SimpleButtonTest());
			addTest(new as3ui.controls.scrollbar.BaseScrollBarTest());
			addTest(new as3ui.UIObjectTest());
			addTest(new as3ui.utils.stage.TopLevelTest());
			addTest(new as3ui.video.MediaTest());
		}
	}
}
