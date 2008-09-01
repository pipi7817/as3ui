package se.konstruktor.as3ui.controls.button
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class SimpleButtonTest extends TestCase
	{
		private var m_instance:SimpleButton;

		public function SimpleButtonTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new SimpleButtonTest());
//	 		ts.addTest(new SimpleButtonTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new SimpleButton(new Sprite());
			// addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("instance is SimpleButton", m_instance is SimpleButton);
		}

		public function testInitialize():void
		{
			var upState:Sprite = new Sprite();
			var overState:Sprite = new Sprite();
			var downState:Sprite = new Sprite();
			var hitArea:Sprite = new Sprite();

			var instance:SimpleButton;

			instance = new SimpleButton(upState);
			assertEquals(upState,instance.m_upState);
			assertEquals(upState,instance.m_overState);
			assertEquals(upState,instance.m_downState);
			assertEquals(upState,instance.m_hitArea);
			
			instance = new SimpleButton(upState,overState);
			assertEquals(upState,instance.m_upState);
			assertEquals(overState,instance.m_overState);
			assertEquals(overState,instance.m_downState);
			assertEquals(upState,instance.m_hitArea);

			instance = new SimpleButton(upState,overState,downState);
			assertEquals(upState,instance.m_upState);
			assertEquals(overState,instance.m_overState);
			assertEquals(downState,instance.m_downState);
			assertEquals(upState,instance.m_hitArea);

			instance = new SimpleButton(upState,overState,downState,hitArea);
			assertEquals(upState,instance.m_upState);
			assertEquals(overState,instance.m_overState);
			assertEquals(downState,instance.m_downState);
			assertEquals(hitArea,instance.m_hitArea);

		}
		
		public function testChangeState():void
		{
			assertEquals(true,m_instance.m_upState.visible);

			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,false,0,0,m_instance,false,false,false,false,0));
			assertEquals(true,m_instance.m_overState.visible);

			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,false,0,0,m_instance,false,false,false,true,0));
			assertEquals(true,m_instance.m_downState.visible);

			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,false,0,0,m_instance,false,false,false,false,0));
			assertEquals(true,m_instance.m_overState.visible);

			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,false,0,0,m_instance,false,false,false,false,0));
			assertEquals(true,m_instance.m_upState.visible);
		}
				

	}
}