package se.konstruktor.as3ui.controls.button
{

	import asunit.framework.AsynchronousTestCase;
	import asunit.framework.TestSuite;
	
	import flash.events.MouseEvent;

	public class BaseButtonTest extends AsynchronousTestCase
	{
		private var m_instance:BaseButton;

		public function BaseButtonTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new BaseButtonTest());
//	 		ts.addTest(new BaseButtonTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new BaseButton();
			addChild(m_instance);
		}

		override protected function tearDown():void
		{
			super.tearDown();
			removeChild(m_instance);
			m_instance = null;
		}

		public function testInstantiated():void
		{
			assertTrue("baseButton is BaseButton", m_instance is BaseButton);
		}
		
		public function testPress():void
		{
			var handler:Function = addAsync(resultTestPress, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.PRESS, handler);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
		}
		
		public function resultTestPress(event:ButtonEvent):void
		{
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.PRESS, event.type);
			assertEquals(instance.m_state, ButtonState.PRESSED);
			assertTrue(instance.m_isFocus);
		}

		public function testPressAndRelease():void
		{
			var handler:Function = addAsync(resultTestPressAndRelease, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.RELEASE, handler);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,instance,false,false,false,false,0));
		}
		
		public function resultTestPressAndRelease(event:ButtonEvent):void
		{
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.RELEASE, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testOver():void
		{
			var handler:Function = addAsync(resultTestOver, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.ROLL_OVER, handler);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,false,0));
		}
		
		public function resultTestOver(event:ButtonEvent):void
		{
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OVER, event.type);
			assertEquals(ButtonState.OVER, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}
		
		public function testOverAndOut():void
		{
			var handler:Function = addAsync(resultTestOverAndOut, 1000);
			var instance:BaseButton = m_instance;
			
			instance.addEventListener(ButtonEvent.ROLL_OUT, handler);

			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,false,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,instance,false,false,false,false,0)); 
		}
		
		public function resultTestOverAndOut(event:ButtonEvent):void
		{
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OUT, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testPressAndOutAndRelease():void
		{
			var handler:Function = addAsync(resultTestPressAndOutAndRelease, 1000);
			var instance:BaseButton = m_instance;
			instance.addEventListener(ButtonEvent.RELEASE_OUTSIDE, handler);

			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,instance,false,false,false,true,0));
			getContext().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,getContext(),false,false,false,false,0));

		}

		public function resultTestPressAndOutAndRelease(event:ButtonEvent):void
		{
			var instance:BaseButton = event.target as BaseButton;
			
			assertEquals(ButtonEvent.RELEASE_OUTSIDE,event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		
		}


	}
}