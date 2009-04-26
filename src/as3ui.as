package {
	import as3ui.display.UISprite;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Keyboard;
	
//	import as3ui.managers.FocusManager;
	
	public class as3ui extends UISprite {

		public function as3ui() {
			trace("as3ui instantiated!");
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			
			

			var toggleButtonExample:ToggleButtonExample = new ToggleButtonExample();
			toggleButtonExample.x = 50;
			toggleButtonExample.y = 150;
			addChild(toggleButtonExample);

			
			var baseButtonExample:BaseButtonExample = new BaseButtonExample();
			baseButtonExample.x = 50;
			baseButtonExample.y = 150;
			baseButtonExample.bindKey(Keyboard.SPACE);
			addChild(baseButtonExample);
//			
//			var simpleButtonExample:SimpleButtonExample = new SimpleButtonExample();
//			simpleButtonExample.x = 50;
//			simpleButtonExample.y = 100;
//			addChild(simpleButtonExample);
//			
//			var textButtonExample:TextButtonExample = new TextButtonExample();
//			textButtonExample.x = 50;
//			textButtonExample.y = 150;
//			addChild(textButtonExample);

//			var vp:VideoPlayerExample = new VideoPlayerExample();
//			vp.x = 50;
//			vp.y = 200;
//			addChild(vp);
		}

	}
}
