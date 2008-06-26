package
{
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import se.konstruktor.as3ui.controls.scrollbar.ScrollBarEvent;
	import se.konstruktor.as3ui.video.ControlBar;
	import se.konstruktor.as3ui.video.LivePlayer;
	import se.konstruktor.as3ui.video.SeekBar;

	public class VideoPlayerExample extends Sprite
	{
		private var m_seekbar:SeekBar;
		private var m_player:LivePlayer;
		private var m_controlbar:ControlBar;
		
		public function VideoPlayerExample()
		{


			m_player = new LivePlayer(320,200);
			m_player.y = 24;
			addChild(m_player);

			m_controlbar = new ControlBar();
			addChild(m_controlbar);

			m_seekbar = new SeekBar(320-m_controlbar.width);
			m_seekbar.x = m_controlbar.width;
			m_seekbar.y = 0;
			m_seekbar.handle = 0;
			m_seekbar.progress = 0;
			m_seekbar.fullness = 0;
			addChild(m_seekbar);
			
			
			addEventListener(Event.ADDED_TO_STAGE,init);

			

		}
		
		private function init(event:Event):void
		{
			addEventListners();
		}
		
		private function addEventListners():void
		{

			m_player.addEventListener(ProgressEvent.PROGRESS, onProgress);
			m_player.addEventListener(VideoEvent.STATE_CHANGE,m_controlbar.onChangeState);
			
			m_seekbar.addEventListener(ScrollBarEvent.SCROLL,onScrollSeek);

			m_controlbar.addEventListener("play",onPresPlay);
			m_controlbar.addEventListener("pause",onPresPause);
			m_controlbar.addEventListener("stop",onPresStop);
			m_controlbar.addEventListener("fullscreen",onPresFullscreen);
			
			stage.addEventListener(Event.RESIZE,onResizeStage);

		}
		
		private function onPresPlay(event:Event):void
		{
			if(m_player.state == VideoState.DISCONNECTED || m_player.state == VideoState.CONNECTION_ERROR)
			{
				// m_player.play("http://www0.c00928.cdn.qbrick.com/00928/kluster/20080612/SOMMARTORPETLINDA2.flv");
//				m_player.play("rtmp://fl0.c00928.cdn.qbrick.com/00928/enc3low");
//				m_player.play("rtmp://fl0.c00451.cdn.qbrick.com/00451/20080610iphoneNYNY_s");
//
//				m_rtmpNC.connect("rtmp://fl0.c00451.cdn.qbrick.com/00451/20080619Spel_s");
//				m_rtmpNC.connect("rtmp://fl0.c00928.cdn.qbrick.com/00928/enc3low");
// 				http://akastreaming.svtiwebb.se/vp/sesvt/se/sesvt_live.xml?gjmf=SESVT_LIVE_1@s2204
				m_player.isAkamai = true;
//				m_player.play("http://akastreaming.svtiwebb.se/vp/sesvt/se/sesvt_live.xml?gjmf=SESVT_LIVE_1@s2204");
				m_player.play("http://ebustreaming.fr.edgesuite.net/akamai/flash/event.xml?gjmf=flash/filename");

//				m_player.isAkamai = false;
////				m_player.play("rtmp://fl0.c00928.cdn.qbrick.com/00928/enc3low");
//				m_player.play("rtmp://fl0.c00928.cdn.qbrick.com/00000/denied");
			}
			else 
			{
				m_player.play();
			}
		}
		
		private function onPresPause(event:Event):void
		{
			m_player.pause();
		}

		private function onPresStop(event:Event):void
		{
			m_player.stop();
		}

		private function onPresFullscreen(event:Event):void
		{
			if(stage.displayState==StageDisplayState.NORMAL)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else
			{
				stage.displayState = StageDisplayState.NORMAL;
			}
		}

		private function onProgress(event:ProgressEvent):void
		{
			m_seekbar.totalTime = m_player.totalTime;
			m_seekbar.currentTime = m_player.playheadTime;
			m_seekbar.fullness = m_player.playheadPercentage;
			m_seekbar.progress = m_player.progress;
		}

		private function onResizeStage(event:Event):void
		{
			if(stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				m_player.setSize(stage.stageWidth,stage.stageHeight);
				m_player.globalX = 0;
				m_player.globalY = 0;
				m_controlbar.globalX = 0;
				m_controlbar.globalY = 0;
				m_seekbar.globalX = m_controlbar.width;
				m_seekbar.globalY = 0;
			}	
			else 
			{
				m_player.setSize(320,200);
				m_player.y = 24;
				m_player.x = 0;
				m_controlbar.x = 0;
				m_controlbar.y = 0;
				m_seekbar.x = m_controlbar.width;
				m_seekbar.y = 0;

			}
		}
		
		private function onScrollSeek(event:ScrollBarEvent):void
		{
			// m_player.seekPercent(m_seekbar.handle);
		}

		
	}
}