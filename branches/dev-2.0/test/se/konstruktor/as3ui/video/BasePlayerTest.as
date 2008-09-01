package se.konstruktor.as3ui.video {

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import fl.video.MetadataEvent;
	import fl.video.VideoEvent;
	import fl.video.VideoState;
	
	import flash.events.Event;

	public class BasePlayerTest extends TestCase {
		private var m_instance:BasePlayer;
		private var m_handler:Function;
		
		private static const MOVIE_GOOD:String = "../test/se/konstruktor/as3ui/video/movie43.flv";
		private static const MOVIE_BAD:String = "../test/se/konstruktor/as3ui/video/bad_url.flv";
		private static const MOVIE_43:String = "../test/se/konstruktor/as3ui/video/movie43.flv";
		private static const MOVIE_169:String = "../test/se/konstruktor/as3ui/video/movie169.flv";

		public function BasePlayerTest(methodName:String=null) {
			super(methodName)
		}

		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new BasePlayerTest());
//	 		ts.addTest(new BasePlayerTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void {
			super.setUp();
			m_handler = null;
			m_instance = new BasePlayer(320,240);
			addChild(m_instance);
		}

		override protected function tearDown():void {
			super.tearDown();
			removeChild(m_instance);
			m_instance.closeNS();
			m_handler = null;
			m_instance = null;
		}

		public function testInstantiated():void {
			assertTrue("basePlayer is BasePlayer", m_instance is BasePlayer);
		}

		public function testPlay():void {
			

			var instance:BasePlayer = m_instance;
			instance.addEventListener( VideoEvent.STATE_CHANGE , addAsync(resultEnterPlayState, 1000),false,0,true );
			instance.play(MOVIE_GOOD);
			
			assertEquals(MOVIE_GOOD,instance.source);
		}


		public function testPlayPause():void {

			var instance:BasePlayer = m_instance;
			m_handler = addAsync(resultEnterPlayStateSetPause, 1000);
			instance.addEventListener( VideoEvent.STATE_CHANGE , m_handler,false,0,true );

			instance.play(MOVIE_GOOD);
			assertEquals(MOVIE_GOOD,instance.source);
		}

		private function resultEnterPlayStateSetPause(event:VideoEvent):void
		{
			var instance:BasePlayer = event.target as BasePlayer;
			assertEquals(VideoState.PLAYING, instance.state);
			instance.removeEventListener(VideoEvent.STATE_CHANGE,m_handler);
			instance.addEventListener( VideoEvent.STATE_CHANGE , addAsync(resultEnterPauseState, 1000),false,0,true );
			instance.pause();
		}

		private function resultEnterPauseState(event:VideoEvent):void
		{
			var instance:BasePlayer = event.target as BasePlayer;
			assertEquals(VideoState.PAUSED, instance.state);
		}
		
		private function resultEnterPlayState(event:VideoEvent):void
		{
			var instance:BasePlayer = event.target as BasePlayer;
			assertEquals(VideoState.PLAYING, instance.state);
		}

		public function testMetadata():void {
			var instance:BasePlayer = m_instance;
			instance.addEventListener( MetadataEvent.METADATA_RECEIVED,addAsync(resultMetadataReceived, 1000),false,0,true );
			instance.play(MOVIE_GOOD);
		}
		
		private function resultMetadataReceived(event:Event):void
		{
			assertTrue(event is MetadataEvent);
		}		

		public function testConnectionFailed():void {
			

			var instance:BasePlayer = m_instance;
			instance.addEventListener( VideoEvent.STATE_CHANGE , addAsync(resultConnectionFailedState, 1000),false,0,true );
			instance.play(MOVIE_BAD);
			
		}

		private function resultConnectionFailedState(event:VideoEvent):void
		{
			var instance:BasePlayer = event.target as BasePlayer;
			assertEquals(MOVIE_BAD,instance.source);
			assertEquals(VideoState.CONNECTION_ERROR, instance.state);
		}		


	}
}