package as3ui.managers.subtitlemanager
{

	import as3ui.managers.subtitlemanager.events.SubtitleTriggerEvent;
	import as3ui.managers.subtitlemanager.vo.Text;
	
	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import flash.events.Event;

	public class TriggerTest extends TestCase
	{
		private var m_instance:Trigger;
		private var m_data:XML;
		private var m_result:Array;;
		public function TriggerTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new TriggerTest());
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_data = <action type="SHOW" trigger="ShowText1">
				<text timeout="200" position="bottom"><![CDATA[Text 1]]></text>
				<text timeout="400" delay="200" position="top"><![CDATA[Text 2]]></text>
				<text delay="300"><![CDATA[Text 3]]></text>
			</action>;
						
			m_instance = new Trigger(m_data);
			m_result = [];
			
			// addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
			m_result = null;
		}

		public function testInstantiated():void
		{
			assertTrue("trigger is Trigger", m_instance is Trigger);
		}
		
		public function testContent(): void
		{
			assertEquals( 200,(m_instance.m_content[0] as Text).timeout);
			assertEquals( 0,(m_instance.m_content[0] as Text).delay);
			assertEquals( "bottom",(m_instance.m_content[0] as Text).position);
			assertEquals( "Text 1",(m_instance.m_content[0] as Text).data);

			assertEquals( 400,(m_instance.m_content[1] as Text).timeout);
			assertEquals( 200,(m_instance.m_content[1] as Text).delay);
			assertEquals( "top",(m_instance.m_content[1] as Text).position);
			assertEquals( "Text 2",(m_instance.m_content[1] as Text).data);

			assertEquals( 0,(m_instance.m_content[2] as Text).timeout);
			assertEquals( 300,(m_instance.m_content[2] as Text).delay);
			assertEquals( "bottom",(m_instance.m_content[2] as Text).position);
			assertEquals( "Text 3",(m_instance.m_content[2] as Text).data);

		}
	
		public function testPlay() : void
		{
			var handler:Function = addAsync(handleTestPlay, 3000);
			m_instance.addEventListener(SubtitleTriggerEvent.UPDATE, function(a_event:Event):void
			{
				m_result.push( a_event.target.text );
			},false,0,true);
			
			m_instance.addEventListener(SubtitleTriggerEvent.DEACTIVATE,handler,false,0,true);
			m_instance.play();
		}
		

		
		private function handleTestPlay(a_event:Event) : void
		{
			assertEquals("Text 1,Text 2,Text 3",m_result.toString());		
		}
		
	}
}