package as3ui.controls.button
{

	import asunit.framework.AsynchronousTestCase;
	import asunit.framework.TestSuite;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

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
//	 		ts.addTest(new BaseButtonTest("testPreSetEnabled"));
   			return ts;
   		}

		override protected function setUp():void
		{
			m_instance = new BaseButton();
			addChild(m_instance);
			super.setUp();
		}

		override protected function tearDown():void
		{
			removeChild(m_instance);
			// m_instance = null;
			super.tearDown();
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
			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.PRESS, event.type);
			assertEquals(instance.m_state, ButtonState.PRESSED);
			assertTrue(instance.m_isFocus);
		}

		public function testPressAndRelease():void
		{
			var handler:Function = addAsync(resultTestPressAndRelease, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.RELEASE, handler,false,0,true);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,instance,false,false,false,false,0));
		}
		
		public function resultTestPressAndRelease(event:ButtonEvent):void
		{

			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.RELEASE, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testOverAndPressAndRelease():void
		{
			var handler:Function = addAsync(resultTestOverAndPressAndRelease, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.RELEASE, handler,false,0,true);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,false,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,instance,false,false,false,false,0));
		}

		public function resultTestOverAndPressAndRelease(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.RELEASE, event.type);
			assertEquals(ButtonState.OVER, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testOverAndMouseDownAndPressAndRelease():void
		{
			var handler:Function = addAsync(resultTestOverAndMouseDownAndPressAndRelease, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.RELEASE, handler,false,0,true);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,false,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,instance,false,false,false,false,0));
		}

		public function resultTestOverAndMouseDownAndPressAndRelease(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.RELEASE, event.type);
			assertEquals(ButtonState.OVER, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testMouseDownAndOverAndAndRelease():void
		{
			var handler:Function = addAsync(resultTestMouseDownAndOverAndAndRelease, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.ROLL_OVER, handler,false,0,true);
//			instance.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,instance,false,false,false,false,0));
		}

		public function resultTestMouseDownAndOverAndAndRelease(event:ButtonEvent):void
		{

			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OVER, event.type);
			assertEquals(ButtonState.OVER, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}


		public function testOver():void
		{
			var handler:Function = addAsync(resultTestOver, 1000);
			var instance:BaseButton = m_instance;

			instance.addEventListener(ButtonEvent.ROLL_OVER, handler,false,0,true);
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,false,0));
		}
		
		public function resultTestOver(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OVER, event.type);
			assertEquals(ButtonState.OVER, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}
		
		public function testOverAndOut():void
		{
			var handler:Function = addAsync(resultTestOverAndOut, 1000);
			var instance:BaseButton = m_instance;
			
			instance.addEventListener(ButtonEvent.ROLL_OUT, handler,false,0,true);

			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,false,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,instance,false,false,false,false,0)); 
		}
		
		public function resultTestOverAndOut(event:ButtonEvent):void
		{

			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OUT, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testPressAndOutAndRelease():void
		{
			var handler:Function = addAsync(resultTestPressAndOutAndRelease, 1000);
			var instance:BaseButton = m_instance;
			instance.addEventListener(ButtonEvent.RELEASE_OUTSIDE, handler,false,0,true);

			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,instance,false,false,false,true,0));
			getContext().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,getContext(),false,false,false,false,0));


		}

		public function resultTestPressAndOutAndRelease(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);

			var instance:BaseButton = event.target as BaseButton;
			
			assertEquals(ButtonEvent.RELEASE_OUTSIDE,event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function testSetToggled():void
		{
			assertEquals(false, m_instance.toggled);

			m_instance.toggled = true;
			assertEquals(true, m_instance.toggled);
			
			m_instance.toggled = false;
			assertEquals(false, m_instance.toggled);
			
		}

		public function testToggledEvent():void
		{
			var handler:Function = addAsync(resultTestToggled, 1000);
			var instance:BaseButton = m_instance;
			instance.addEventListener(ButtonEvent.TOGGLE, handler,false,0,true);
			instance.toggled = true;
		}

		public function testToggledAndMouseEvent():void
		{
			m_instance.toggled = true;
			m_instance.addEventListener(ButtonEvent.CHANGE_STATE, resultFailStateEvent,false,0,true);
			
			m_instance.toggled = true;
			m_instance.addEventListener(ButtonEvent.TOGGLE, resultFailToggledEvent,false,0,true);
			m_instance.toggled = true;

			m_instance.addEventListener(ButtonEvent.ROLL_OVER, resultTrigerOverEvent,false,0,true);
			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,m_instance,false,false,false,false,0));

			m_instance.addEventListener(ButtonEvent.PRESS, resultTrigerPressEvent,false,0,true);
			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,m_instance,false,false,false,true,0));
			
			m_instance.addEventListener(ButtonEvent.RELEASE, resultTrigerReleaseEvent,false,0,true);
			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,m_instance,false,false,false,false,0));

			m_instance.addEventListener(ButtonEvent.ROLL_OUT, resultTrigerOutEvent,false,0,true);
			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,m_instance,false,false,false,false,0));
		}

		public function resultFailStateEvent(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			assertEquals("resultFailStateEvent should not be trigger", "false");
		}
		
		public function resultFailToggledEvent(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			assertEquals("resultFailToggledEvent should not be trigger", "false");
		}

		public function resultTrigerOverEvent(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OVER, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function resultTrigerPressEvent(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.PRESS, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(true, instance.m_isFocus);
		}

		public function resultTrigerReleaseEvent(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.RELEASE, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function resultTrigerOutEvent(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OUT, event.type);
			assertEquals(ButtonState.RELEASED, instance.m_state);
			assertEquals(false, instance.m_isFocus);
		}

		public function resultTestToggled(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.TOGGLE,event.type);
		}
		
		public function testSetFocous():void
		{
			
			assertEquals(false,m_instance.isFocus);

			m_instance.setFocus(true);
			assertEquals(true,m_instance.isFocus);

			m_instance.setFocus(false);
			assertEquals(false,m_instance.isFocus);

		}

		public function testPressAndOutAndOver():void
		{
			var handler:Function = addAsync(resultTestPressAndOutAndOver, 1000);
			var instance:BaseButton = m_instance;
			instance.addEventListener(ButtonEvent.ROLL_OVER_WHILE_DOWN, handler,false,0,true);

			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,true,0));
			assertEquals(ButtonState.PRESSED,instance.m_state);
		}
		
		public function resultTestPressAndOutAndOver(event:ButtonEvent):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonEvent.ROLL_OVER_WHILE_DOWN,event.type);
		}

		public function testMouseDownAndOver():void
		{
			var instance:BaseButton = m_instance;
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,instance,false,false,false,true,0));
			assertEquals(ButtonState.RELEASED,instance.m_state);
		}
		
		public function testPressAndDragAndOutAndRelese():void
		{
			var handler:Function = addAsync(resultTestPressAndDragAndOutAndRelese, 1000);
			var instance:BaseButton = m_instance;
			instance.addEventListener(ButtonEvent.RELEASE_OUTSIDE, handler,false,0,true);

			instance.startDrag(false,new Rectangle(0,0,100,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,instance,false,false,false,true,0));
			instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT,true,true,0,0,instance,false,false,false,true,0));
			instance.stopDrag();
			
			getContext().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,getContext(),false,false,false,false,0));
			
			assertEquals(ButtonState.RELEASED,instance.m_state);
		}

		private function resultTestPressAndDragAndOutAndRelese(event:Event):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			var instance:BaseButton = event.target as BaseButton;
			assertEquals(ButtonState.RELEASED,instance.m_state);

		}

//		public function testPressAndDisableAndRelese():void
//		{
//			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER,true,true,0,0,m_instance,false,false,false,false,0));
//			assertEquals(ButtonState.OVER,m_instance.m_state);
//			
//			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,true,0,0,m_instance,false,false,false,true,0));
//			assertEquals(ButtonState.PRESSED,m_instance.m_state);
//
//			m_instance.setEnabled(false);
//			assertEquals(ButtonState.DISABLED,m_instance.m_state);
//
//			m_instance.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,true,0,0,m_instance,false,false,false,false,0));
//			assertEquals(ButtonState.DISABLED,m_instance.m_state);
//	
//
//		}
//		
		public function testKeyPress():void
		{
			var handler:Function = addAsync(resultTestKeyPress, 1000);
			m_instance.addEventListener(ButtonEvent.CHANGE_STATE, handler,false,0,true);
			m_instance.bindKey(Keyboard.SPACE);
			context.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN,true,true,0,Keyboard.SPACE) );
		}
		
		private function resultTestKeyPress(event:Event):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			assertEquals(ButtonState.PRESSED,m_instance.m_state);
		}

		public function testKeyRelease():void
		{
			var handler:Function = addAsync(resultTestKeyRelease, 1000);
			m_instance.bindKey(Keyboard.SPACE);

			context.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN,true,true,0,Keyboard.SPACE) );

			m_instance.addEventListener(ButtonEvent.CHANGE_STATE, handler,false,0,true);

			context.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP,true,true,0,Keyboard.SPACE) );
		}
		
		private function resultTestKeyRelease(event:Event):void
		{
			event.target.removeEventListener(event.type, arguments.callee);
			assertEquals(ButtonState.RELEASED,m_instance.m_state);
		}
		
		public function testPreSetEnabled():void
		{
			var button:BaseButton = new BaseButton();
			button.setEnabled(false);
			button.setEnabled(true);
			
		}
						
	}
}