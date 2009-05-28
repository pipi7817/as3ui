package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */


	import as3ui.controls.button.BaseButtonTest;
	import as3ui.controls.button.SimpleButtonTest;
	import as3ui.controls.scrollbar.BaseScrollBarTest;
	import as3ui.display.UISpriteTest;
	import as3ui.utils.stage.TopLevelTest;
	import as3ui.video.MediaTest;
	
	import asunit.framework.TestSuite;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new BaseButtonTest());
			addTest(new SimpleButtonTest());
			addTest(new BaseScrollBarTest());
			addTest(new UISpriteTest());
			addTest(new TopLevelTest());
			addTest(new MediaTest());
		}
	}
}
