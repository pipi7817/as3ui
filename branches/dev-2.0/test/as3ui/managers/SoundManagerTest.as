package as3ui.managers
{

	import as3ui.utils.EmbeddedSwfLoader;
	
	import asunit.framework.AsynchronousTestCase;
	import asunit.framework.TestSuite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	public class SoundManagerTest extends AsynchronousTestCase
	{

      [Embed("Sound.swf", mimeType="application/octet-stream")]
      private static const SoundFile:Class;
      


		private var m_instance:SoundManager;
		private var m_broadcaster:Sprite;
		private var m_data:XML;
		
		public function SoundManagerTest(methodName:String=null)
		{
			
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new SoundManagerTest());
//	 		ts.addTest(new SoundManagerTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_broadcaster = new Sprite();
			m_instance = new SoundManager( m_broadcaster );
			m_data = <actions>
				<action type="PLAY" trigger="PlayTestSound1">
					<linkage>Sound1_wav</linkage>
					<volume>0</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>		

				<action type="PLAY" trigger="PlayTestSound2">
					<linkage>Sound2_wav</linkage>
					<volume>0</volume>
					<pan>0</pan>
					<delay>0</delay>
					<loop>false</loop>
					<position>0</position>
					<global>false</global>
				</action>
				</actions>;
			//addChild(m_instance);
			
			var embedLoader:EmbeddedSwfLoader = new EmbeddedSwfLoader();
			
			embedLoader.load( new SoundFile() );
			embedLoader.addEventListener(Event.COMPLETE,onPreLoadComplete);
		}
		
		private function onPreLoadComplete(event:Event) : void
		{
			trace("complete");

			trace( "==>>" + getDefinitionByName("Ambient.wav") );
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("instance is SoundManager", m_instance is SoundManager);
		}

		public function testSetup() : void
		{

			
			m_instance.loadConfig( m_data );

			assertEquals(["PlayTestSound1","PlayTestSound2"].toString(), m_instance.getTriggerList().toString());

		}

		public function testTrigger() : void
		{
			
			m_instance.loadConfig( m_data );
			
			assertFalse( m_instance.isPlaying )
			m_instance.m_root.dispatchEvent( new Event("PlayTestSound1",true,true) );			
			assertTrue( m_instance.isPlaying )
		}

		public function testGetAction() : void
		{
			m_instance.loadConfig( m_data );
			
			var obj:Object = m_instance.getAction("PlayTestSound1");
			
			assertEquals(obj.linkage,"Sound1_wav");
		}		

	}
}