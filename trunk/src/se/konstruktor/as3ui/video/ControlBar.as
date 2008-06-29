package se.konstruktor.as3ui.video
{
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	
	import flash.events.Event;
	
	import se.konstruktor.as3ui.UIObject;
	import se.konstruktor.as3ui.controls.button.ButtonEvent;
	import se.konstruktor.as3ui.video.controlbar.Button;

	public class ControlBar extends UIObject
	{
		
		// graphics 
		[Embed(source='../src/resources/png/video/controlbar/Play.png')]
		private var PLAY_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Pause.png')]
		private var PAUSE_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Stop.png')]
		private var STOP_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Volume.png')]
		private var VOLUME_PNG:Class;
		
		[Embed(source='../src/resources/png/video/controlbar/Button.png')]
		private var BUTTON_PNG:Class;

		[Embed(source='../src/resources/png/video/controlbar/Fullscreen.png')]
		private var FULLSCREEN_PNG:Class;

		private var m_play:Button;
		private var m_stop:Button;
		private var m_pause:Button;
		private var m_fullscreen:Button;
		
		public function ControlBar()
		{
			super();

			m_play= new Button(new BUTTON_PNG(), new PLAY_PNG());
			m_pause = new Button(new BUTTON_PNG(), new PAUSE_PNG());
			m_stop = new Button(new BUTTON_PNG(), new STOP_PNG());
			m_fullscreen = new Button(new BUTTON_PNG(), new FULLSCREEN_PNG());

			m_pause.x = m_play.x + m_play.width;
			m_stop.x = m_pause.x + m_pause.width;
			m_fullscreen.x = m_stop.x + m_stop.width;
			
			addChild(m_play);
			addChild(m_pause);
			addChild(m_stop);
			addChild(m_fullscreen);
			
			
			addEventListener(ButtonEvent.PRESS,onPressButton);
		}
		
		private function onPressButton(event:ButtonEvent):void
		{
			switch ( event.target )
			{
				case m_play:
					dispatchEvent(new Event("play",true,true) );
				break;

				case m_stop:
					dispatchEvent(new Event("stop",true,true) );
				break;
				
				case m_pause:
					dispatchEvent(new Event("pause",true,true) );
				break;

				case m_fullscreen:
					dispatchEvent(new Event("fullscreen",true,true) );
				break;
			}
		}
		
		public function onChangeState(event:VideoEvent):void
		{
			m_play.setEnabled(event.state != VideoState.PLAYING);
			m_pause.setEnabled(event.state != VideoState.PAUSED && event.state != VideoState.STOPPED );
			m_stop.setEnabled(event.state != VideoState.STOPPED);
		}
		
	}
}