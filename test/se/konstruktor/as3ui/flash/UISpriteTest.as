package se.konstruktor.as3ui.flash
{

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import se.konstruktor.as3ui.flash.uisprite.UISpriteEvent;

	public class UISpriteTest extends TestCase
	{
		private var m_instance:UISprite;

		public function UISpriteTest(methodName:String=null)
		{
			super(methodName)
		}

		public static function suite():TestSuite
		{
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new UISpriteTest());
//	 		ts.addTest(new BaseUIObjectTest("testInstantiated"));
   			return ts;
   		}

		override protected function setUp():void
		{
			super.setUp();
			m_instance = new UISprite();
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
			assertTrue("instance is BaseUIObject", m_instance is UISprite);
		}

		public function testMove():void
		{
			assertEquals(0,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(0,0);
			assertEquals(0,m_instance.x);
			assertEquals(0,m_instance.y);
			
			m_instance.move(1,0);
			assertEquals(1,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(2,0);
			assertEquals(2,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(0,1);
			assertEquals(0,m_instance.x);
			assertEquals(1,m_instance.y);

			m_instance.move(0,2);
			assertEquals(0,m_instance.x);
			assertEquals(2,m_instance.y);

			m_instance.move(0,0,true);
			assertEquals(0,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(1.1,0,true);
			assertEquals(1,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(1.5,0,true);
			assertEquals(2,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(1.9,0,true);
			assertEquals(2,m_instance.x);
			assertEquals(0,m_instance.y);

			m_instance.move(0,1.1,true);
			assertEquals(0,m_instance.x);
			assertEquals(1,m_instance.y);

			m_instance.move(0,1.5,true);
			assertEquals(0,m_instance.x);
			assertEquals(2,m_instance.y);

			m_instance.move(0,1.9,true);
			assertEquals(0,m_instance.x);
			assertEquals(2,m_instance.y);
		}

		public function testMoveEvent():void
		{
			var handler:Function = addAsync(resultTestMoveEvent, 1000);
			var instance:UISprite = m_instance;
			instance.addEventListener(UISpriteEvent.MOVE,handler);
			instance.move(1,1);
		}

		public function resultTestMoveEvent(event:UISpriteEvent):void
		{
			assertEquals(UISpriteEvent.MOVE, event.type);
		}

		public function testMoveMoveEvent():void
		{
			m_instance.move(1,1);
			m_instance.addEventListener(UISpriteEvent.MOVE,resultFailMoveEvent);
			m_instance.move(1,1);
			m_instance.removeEventListener(UISpriteEvent.MOVE,resultFailMoveEvent);
		}

		public function resultFailMoveEvent(event:UISpriteEvent):void
		{
			assertEquals("resultFailMoveEvent should not be trigger", "false");
		}

		public function testGlobalX():void
		{
			var stage:Stage = m_instance.stage;
			var child1:Sprite = new Sprite();
			var child2:Sprite = new Sprite();
			var child3:Sprite = new Sprite();
			var instance:UISprite = new UISprite();
			
			stage.addChild(child1);
			child1.addChild(child2);
			child2.addChild(child3);

			child1.x = 10;
			child2.x = 20;
			child3.x = 30;

			instance.x = 40;
			
			stage.addChild(instance);
			assertEquals(40,instance.globalX);

			child1.addChild(instance);
			assertEquals(50,instance.globalX);

			child2.addChild(instance);
			assertEquals(70,instance.globalX);

			child3.addChild(instance);
			assertEquals(100,instance.globalX);

			for ( var i:Number=0;i<4;i+=0.5)
			{
				instance.globalX = i;
				assertEquals(i,instance.globalX);
			}

			stage.removeChild(child1);
		}

		public function testGlobalY():void
		{
			
			var stage:Stage = m_instance.stage;
			var child1:Sprite = new Sprite();
			var child2:Sprite = new Sprite();
			var child3:Sprite = new Sprite();
			var instance:UISprite = new UISprite();
			
			stage.addChild(child1);
			child1.addChild(child2);
			child2.addChild(child3);

			child1.y = 10;
			child2.y = 20;
			child3.y = 30;

			instance.y = 40;
			
			stage.addChild(instance);
			assertEquals(40,instance.globalY);

			child1.addChild(instance);
			assertEquals(50,instance.globalY);

			child2.addChild(instance);
			assertEquals(70,instance.globalY);

			child3.addChild(instance);
			assertEquals(100,instance.globalY);

			for ( var i:Number=0;i<4;i+=0.5)
			{
				instance.globalY = i;
				assertEquals(i,instance.globalY);
			}

			stage.removeChild(child1);
			
		}
		
		public function testShow():void
		{
			var handler:Function = addAsync(resultTestShow, 1000);
			var instance:UISprite = m_instance;
			instance.addEventListener(UISpriteEvent.SHOW_COMPLETE,handler);
			instance.visible = false;
			instance.show();
		}

		public function resultTestShow(event:UISpriteEvent):void
		{
			var instance:UISprite = event.target as UISprite;
			assertEquals(UISpriteEvent.SHOW_COMPLETE, event.type);
			assertEquals(true, instance.visible);
		}

		public function testHide():void
		{
			var handler:Function = addAsync(resultTestHide, 1000);
			var instance:UISprite = m_instance;
			instance.addEventListener(UISpriteEvent.HIDE_COMPLETE,handler);
			instance.visible = true;
			instance.hide();
		}

		public function resultTestHide(event:UISpriteEvent):void
		{
			var instance:UISprite = event.target as UISprite;
			assertEquals(UISpriteEvent.HIDE_COMPLETE, event.type);
			assertEquals(false, instance.visible);
		}
		
		public function testSetSize():void
		{
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(1, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(2,0);
			assertEquals(2, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(-1,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);



			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(0,2);
			assertEquals(0, m_instance.width);
			assertEquals(2, m_instance.height);

			m_instance.setSize(0,-1);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);



			m_instance.setSize(0,0,true);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1.1,0,true);
			assertEquals(1, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1.5,0,true);
			assertEquals(2, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1.9,0,true);
			assertEquals(2, m_instance.width);
			assertEquals(0, m_instance.height);



			m_instance.setSize(0,0,true);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1.1,true);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(0,1.5,true);
			assertEquals(0, m_instance.width);
			assertEquals(2, m_instance.height);
			
			m_instance.setSize(0,1.9,true);
			assertEquals(0, m_instance.width);
			assertEquals(2, m_instance.height);
		}

		public function testSetMinSizeAndSetSize():void
		{
			m_instance.setMinSize(0,0);

			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(1, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,1);
			assertEquals(1, m_instance.width);
			assertEquals(1, m_instance.height);



			m_instance.setMinSize(0,1);

			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(1, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(1,1);
			assertEquals(1, m_instance.width);
			assertEquals(1, m_instance.height);



			m_instance.setMinSize(1,0);

			m_instance.setSize(0,0);
			assertEquals(1, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(1, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(1, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,1);
			assertEquals(1, m_instance.width);
			assertEquals(1, m_instance.height);
		
		}
		
		public function testSetMaxSizeAndSetSize():void
		{

			m_instance.setMaxSize(0,0);

			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,1);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);



			m_instance.setMaxSize(0,1);

			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,1);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);			



			m_instance.setMaxSize(1,1);

			m_instance.setSize(0,0);
			assertEquals(0, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(0,1);
			assertEquals(0, m_instance.width);
			assertEquals(1, m_instance.height);

			m_instance.setSize(1,0);
			assertEquals(1, m_instance.width);
			assertEquals(0, m_instance.height);

			m_instance.setSize(1,1);
			assertEquals(1, m_instance.width);
			assertEquals(1, m_instance.height);			


		}

	}
}