package
{
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	import as3ui.controls.button.BaseButtonTest;
	import as3ui.controls.button.SimpleButtonTest;
	import as3ui.controls.form.FormInputTest;
	import as3ui.controls.input.BaseInputTest;
	import as3ui.controls.scrollbar.BaseScrollBarTest;
	import as3ui.managers.FocusManagerTest;
	import as3ui.managers.soundmanager.TriggerTest;
	import as3ui.managers.SoundManagerTest;
	import as3ui.managers.subtitlemanager.TriggerTest;
	import as3ui.managers.SubtitleManagerTest;
	import as3ui.UIObjectTest;
	import as3ui.utils.stage.TopLevelTest;
	import as3ui.video.BasePlayerTest;
	import as3ui.video.MediaTest;

	public class AllTests extends TestSuite
	{

		public function AllTests()
		{
			addTest(as3ui.controls.button.BaseButtonTest.suite());
//			addTest(as3ui.controls.button.SimpleButtonTest.suite());
//			addTest(as3ui.controls.form.FormInputTest.suite());
//			addTest(as3ui.controls.input.BaseInputTest.suite());
//			addTest(as3ui.controls.scrollbar.BaseScrollBarTest.suite());
//			addTest(as3ui.managers.FocusManagerTest.suite());
//			addTest(as3ui.managers.soundmanager.TriggerTest.suite());
//			addTest(as3ui.managers.SoundManagerTest.suite());
			addTest(as3ui.managers.subtitlemanager.TriggerTest.suite());
//			addTest(as3ui.managers.SubtitleManagerTest.suite());
//			addTest(as3ui.UIObjectTest.suite());
//			addTest(as3ui.utils.stage.TopLevelTest.suite());
//			addTest(as3ui.video.BasePlayerTest.suite());
//			addTest(as3ui.video.MediaTest.suite());
		}

	}
}
