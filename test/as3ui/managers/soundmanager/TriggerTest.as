package as3ui.managers.soundmanager
{

	import as3ui.utils.EmbeddedSwfLoader;
	
	import asunit.framework.AsynchronousTestCase;
	import asunit.framework.TestSuite;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	public class TriggerTest extends AsynchronousTestCase
	{
		[Embed("Sound.swf", mimeType="application/octet-stream")]
		private static const SoundLibrary:Class;
		
		private var m_instance:Trigger;
		private var m_data:XML;
		
		public function TriggerTest(methodName:String=null)
		{
			super(methodName)
		}
		
		public override function run():void
		{
			// Load test sound library assets.
			var loader:EmbeddedSwfLoader = new EmbeddedSwfLoader();

			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.addEventListener(Event.OPEN, openHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
			loader.load( new SoundLibrary() );
		}

		override protected function completeHandler(event:Event):void
		{
			super.run();
		}
				
		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new TriggerTest(	));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new Trigger("Ambient.wav");
			m_data = <actions>
				<action type="PLAY" trigger="PlayTestSound1">
					<linkage>Ambient.wav</linkage>
					<volume>0</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>		

				<action type="PLAY" trigger="PlayTestSound2">
					<linkage>Ambient.wav</linkage>
					<volume>0</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>
				</actions>;
			
			// addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}
		
		public function testPlayStop() : void
		{
			assertFalse("Trigger is not playing",m_instance.playing);
			m_instance.play();
			assertTrue("Trigger is playing",m_instance.playing);
			m_instance.stop();
			assertFalse("Trigger is not playing",m_instance.playing);
		}

		public function testPlayPausePlayStop() : void
		{
			assertFalse("Trigger is not playing",m_instance.playing);
			assertFalse("Trigger is not paused",m_instance.paused);
			m_instance.play();
			assertTrue("Trigger is playing",m_instance.playing);
			assertFalse("Trigger is not paused",m_instance.paused);
			m_instance.pause();
			assertFalse("Trigger is not playing",m_instance.playing);
			assertTrue("Trigger is not paused",m_instance.paused);
			m_instance.resume();
			assertTrue("Trigger is playing",m_instance.playing);
			assertFalse("Trigger is not paused",m_instance.paused);
			m_instance.stop();
			assertFalse("Trigger is not playing",m_instance.playing);
			assertFalse("Trigger is not paused",m_instance.paused);
		}

		public function testPlaySetVolumePausePlayStop() : void
		{
			assertEquals(0,m_instance.volume);
			m_instance.play();
			assertEquals(m_instance.volume,1);
			m_instance.volume = 0.5;
			assertEquals(m_instance.volume,0.5);
			m_instance.pause();
			assertEquals(0,m_instance.volume);
			m_instance.resume();						
			assertEquals(m_instance.volume,0.5);
			m_instance.stop();			
			m_instance.play();			
			assertEquals(m_instance.volume,0.5);
			m_instance.stop();
		}

		public function testInstantiated():void
		{
			assertTrue("trigger is Trigger", m_instance is Trigger);
		}

	}
}