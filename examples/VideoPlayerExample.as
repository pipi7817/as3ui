package
{
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import se.konstruktor.as3ui.controls.scrollbar.ScrollBarEvent;
	import se.konstruktor.as3ui.video.BasePlayer;
	import se.konstruktor.as3ui.video.ControlBar;
	import se.konstruktor.as3ui.video.SeekBar;

	public class VideoPlayerExample extends Sprite
	{
		private var m_seekbar:SeekBar;
		private var m_player:BasePlayer;
		private var m_controlbar:ControlBar;
		
		public function VideoPlayerExample()
		{


			m_player = new BasePlayer(320,200);
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
			
			addEventListners();

			m_player.addEventListener(VideoEvent.STATE_CHANGE,m_controlbar.onChangeState);
			
			m_player.play("http://www0.c00928.cdn.qbrick.com/00928/kluster/20080612/SOMMARTORPETLINDA2.flv");

		}
		
		private function addEventListners():void
		{

			m_player.addEventListener(ProgressEvent.PROGRESS, onProgress);
			
			m_seekbar.addEventListener(ScrollBarEvent.SCROLL,onScrollSeek);

			m_controlbar.addEventListener("play",onPresPlay);
			m_controlbar.addEventListener("pause",onPresPause);
			m_controlbar.addEventListener("stop",onPresStop);
			
		}
		
		private function onPresPlay(event:Event):void
		{
			if(m_player.state == VideoState.DISCONNECTED || m_player.state == VideoState.CONNECTION_ERROR)
			{
				m_player.play("http://www0.c00928.cdn.qbrick.com/00928/kluster/20080612/SOMMARTORPETLINDA2.flv");
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

		private function onProgress(event:ProgressEvent):void
		{
			m_seekbar.totalTime = m_player.totalTime;
			m_seekbar.currentTime = m_player.playheadTime;
			m_seekbar.fullness = m_player.playheadPercentage;
			m_seekbar.progress = m_player.progress;
		}

		private function onScrollSeek(event:ScrollBarEvent):void
		{
			m_player.seekPercent(m_seekbar.handle);
		}

		
	}
}