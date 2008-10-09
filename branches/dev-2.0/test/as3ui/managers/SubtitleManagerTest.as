package as3ui.managers
{

	import as3ui.managers.subtitlemanager.events.SubtitleEvent;
	
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import flash.events.Event;

	public class SubtitleManagerTest extends TestCase
	{
		private var m_instance:SubtitleManager;
		private var m_data:XML;
		
		public function SubtitleManagerTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new SubtitleManagerTest());
   			return ts;
   		}
   		
		override protected function setUp():void
		{
			super.setUp();
			SubtitleManager.setContext( context );
			
			m_instance = SubtitleManager.instance;
		
			m_data = <actions>
						<action type="SHOW" trigger="ShowText1">
							<text><![CDATA[Lorem ipsum dolor sit amet, consectetuer adipiscing elit.]]></text>
							<timeout>2000</timeout>
							<delay>250</delay>
						</action>
						<action type="SHOW" trigger="ShowText2">
							<text><![CDATA[In nulla. Fusce sit amet justo. Nulla odio dolor, accumsan eu.]]></text>
							<timeout>0</timeout>
							<delay>0</delay>
						</action>
						<action type="CLEAR" trigger="ClearText">
							<text><![CDATA[]]></text>
							<timeout>0</timeout>
							<delay>0</delay>
						</action>
						<action type="HIDE" trigger="HideText">
							<text><![CDATA[]]></text>
							<timeout>0</timeout>
							<delay>0</delay>
						</action>
					 </actions>;
			
			SubtitleManager.loadConfig(m_data);
			
		}
		
		override protected function tearDown():void
		{
			super.tearDown();
			SubtitleManager.instance.destroy();
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("instance is SubtitleManager", m_instance is SubtitleManager);
		}
		
		public function testLoadConfig() : void
		{
			SubtitleManager.loadConfig( m_data );
			assertEquals(["ShowText1","ShowText2","ClearText","HideText"].toString(), m_instance.getTriggerList().toString());
		}

//		public function testTriggerShow() : void
//		{
//			var handler:Function = addAsync(handleTriggerShow, 1000);
//			m_instance.addEventListener(SubtitleEvent.SHOW,handler);
//			context.dispatchEvent( new Event("ShowText1",true,true) );
//		}

		public function testTriggerHide() : void
		{
			var handler:Function = addAsync(handleTriggerHide, 1000);
			m_instance.addEventListener(SubtitleEvent.HIDE,handler);
			context.dispatchEvent( new Event("ShowText1",true,true) );
		}

		public function handleTriggerShow(a_event:SubtitleEvent) : void
		{
			assertEquals( SubtitleEvent.SHOW,a_event.type );
			assertEquals("Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",a_event.text);
		}

		public function handleTriggerHide(a_event:SubtitleEvent) : void
		{
			assertEquals( SubtitleEvent.HIDE,a_event.type );
		}


		public function testIlegalEvent() : void
		{
			SubtitleManager.loadConfig( m_data );
			context.dispatchEvent( new Event("ShowIlegal",true,true) );
		}
		

		public function testDestroy() : void
		{
			SubtitleManager.instance.destroy();
			assertNull(m_instance.m_root);			
			assertFalse(m_instance.m_loaded);			
			assertNull(m_instance.m_triggers = null);			
			assertNull(m_instance.m_data = null);			
		}

	}
}