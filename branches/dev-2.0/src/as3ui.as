package {
	import as3ui.UIObject;
	import as3ui.video.BasePlayer;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
//	import as3ui.managers.FocusManager;
	
	public class as3ui extends UIObject {

		public function as3ui() {
			trace("as3ui instantiated!");
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			
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
			
			
//			var input:RoundTextInput = new RoundTextInput()
//			input.x = 50;
//			input.y = 50;
//			addChild(input);
//						
			var vp:VideoPlayerExample = new VideoPlayerExample();
			vp.x = 50;
			vp.y = 200;
			addChild(vp);

//			var ti:FormInput = new FormInput(new RoundTextInput(),"",true);
//			ti.x = 50;
//			ti.y = 100;
//			addChild(ti);

			var st:SubtitleExample = new SubtitleExample();
			st.y = 100;
			addChild(st);
			
			
////			var fm:FocusManager = new FocusManager();
//
//
//			var player:BasePlayer = new BasePlayer(300,200);
//			addChild(player);
////			player.addEventListener(VideoEvent.STATE_CHANGE,changeState);
////			player.addEventListener(VideoEvent.COMPLETE,loop);
////			player.play("http://fujisan.acne.se/axe/stage/video/login_loop.flv"); 
//
//
//			var player2:BasePlayer = new BasePlayer(600,400);
//			player2.x = 400;
////			player2.setSize(300,500);
//			addChild(player2);
////			player.addEventListener(VideoEvent.STATE_CHANGE,changeState);
////			player.addEventListener(VideoEvent.COMPLETE,loop);
////			player2.play("http://fujisan.acne.se/axe/stage/video/intro.flv"); 
						
		}
		


		private function changeState(e:Event) : void
		{
			trace( "==>" + (e.target as BasePlayer).state );
		}
		
		private function loop(e:Event) : void
		{
			(e.target as BasePlayer).play();
		}
	}
}
