package as3ui.managers
{

	import as3ui.events.SoundEvent;
	import as3ui.utils.EmbeddedSwfLoader;
	
	import asunit.framework.AsynchronousTestCase;
	import asunit.framework.TestSuite;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundManagerTest extends AsynchronousTestCase
	{
		[Embed("soundmanager/Sound.swf", mimeType="application/octet-stream")]
		private static const SoundFile:Class;

		private var m_instance:SoundManager;
		private var m_data:XML;
		
		public function SoundManagerTest(methodName:String=null)
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
			
			loader.load( new SoundFile() );
		}
		
		override protected function completeHandler(event:Event):void
		{
			super.run();
		}
				
		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new SoundManagerTest());
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new SoundManager( context );
			m_data = <actions>
				<action type="PLAY" trigger="PlayTestSound1">
					<linkage>Ambient.wav</linkage>
					<volume>1</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>		

				<action type="STOP" trigger="StopTestSound1">
					<linkage>Ambient.wav</linkage>
					<volume>1</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>
				
				<action type="PLAY" trigger="PlayTestSound2">
					<linkage>RunLoop.wav</linkage>
					<volume>1</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>
				</actions>;
			
		}

		override protected function tearDown():void
		{
			trace("tearDown");
			super.tearDown();
			//removeChild(m_instance);
			m_instance.destroy();
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("instance is SoundManager", m_instance is SoundManager);
		}

		public function testSetup() : void
		{
			m_instance.loadConfig( m_data );
			assertEquals(["PlayTestSound1","StopTestSound1","PlayTestSound2"].toString(), m_instance.getTriggerList().toString());
		}

		public function testTriggerPlay() : void
		{
//
			m_instance.loadConfig( m_data );
//			var handler:Function = addAsync(triggerHandler, 2000);
			
			context.dispatchEvent( new Event("PlayTestSound1",true,true) );		
			context.dispatchEvent( new Event("StopTestSound1",true,true) );		

		}

		protected function triggerHandler( a_event:SoundEvent ) : void
		{
			assertTrue(true);
//			assertEquals(a_event.type,SoundEvent.PLAY);
//			assertEquals(a_event.trigger,"PlayTestSound1");
//			var sound:Sound = m_instance.getSound("PlayTestSound1");
//			assertEquals(5456,Math.floor(sound.length));
		}
		
//		public function testPlay() : void
//		{
//			m_instance.loadConfig( m_data );
//			var channel:SoundChannel = m_instance.playSound("PlayTestSound1");
//			assertNotNull(channel);
//			assertSame(channel,m_instance.getActiveChannel("PlayTestSound1"));
//			assertEquals(5456,Math.floor(m_instance.getActiveSound("PlayTestSound1").length));
//		}
		


//		public function testTriggerPlay() : void
//		{
//			var handler:Function = addAsync(triggerHandler, 1000);
//
//			var sound:Sound = m_instance.getSound("PlayTestSound1");
//			context.dispatchEvent( new Event("PlayTestSound1",true,true) );	
//			
//		}		

		public function testGetAction() : void
		{
			m_instance.loadConfig( m_data );
			var obj:Object = m_instance.getAction("PlayTestSound1");
			assertEquals(obj.linkage,"Ambient.wav");
		}		

	}
}