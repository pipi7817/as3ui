package as3ui.utils.away3d {

	import asunit.framework.TestCase;
	import asunit.framework.TestSuite;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.math.Number3D;

	public class Object3DUtilTest extends TestCase {
		private var m_instance:Object3DUtil;

		public function Object3DUtilTest(methodName:String=null) {
			super(methodName)
		}

		public static function suite():TestSuite {
  			
   			var ts:TestSuite = new TestSuite();
	 		ts.addTest(new Object3DUtilTest());
   			return ts;
   		}

		override protected function setUp():void {
			super.setUp();
			m_instance = new Object3DUtil();
			// addChild(m_instance);
		}

		override protected function tearDown():void {
			super.tearDown();
			//removeChild(m_instance);
			m_instance = null;
		}

		public function testSetLocationGlobal():void
		{
			var view:View3D = new View3D();
			getContext().addChild(view);
			
			var container1:ObjectContainer3D = new ObjectContainer3D();
			var container2:ObjectContainer3D = new ObjectContainer3D();
			var container3:ObjectContainer3D = new ObjectContainer3D();
			var object3d:Object3D = new Object3D();
			
			container1.x = 10;
			container2.x = 10;
			container3.x = 10;
			object3d.x = 45;
			
			
			
			var xpos:int;
			
			view.scene.addChild(container1);
			container1.addChild(container2);
			container2.addChild(container3);

			xpos = 100;
			view.scene.addChild(object3d);
			object3d.position = Object3DUtil.setLocationGlobal(object3d,new Number3D(xpos,0,0));
			assertEquals(xpos - view.x ,object3d.position.x);
			
			container1.addChild(object3d);
			object3d.position = Object3DUtil.setLocationGlobal(object3d,new Number3D(xpos,0,0));
			assertEquals(xpos - view.x - container1.x ,object3d.position.x);
		
			container2.addChild(object3d);
			object3d.position = Object3DUtil.setLocationGlobal(object3d,new Number3D(xpos,0,0));
			assertEquals(xpos - view.x - container1.x -container2.x ,object3d.position.x);
		}
	}
}