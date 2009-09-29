package as3ui.utils.away3d
{
	import away3d.core.base.Object3D;
	import away3d.core.math.Number3D;
	
	
	public class Object3DUtil {
		
		public function Object3DUtil() {
		} 
	
		static public function setLocationGlobal(a_obj:Object3D,a_global:Number3D):Number3D
		{
			
//			trace(a_obj.position);
//			trace(a_obj.scenePosition);
//			trace(a_obj.sceneTransform);
//			trace(a_obj.transform);
//			trace(a_obj.inverseSceneTransform);
//			trace(a_obj.x);
//			trace(a_global);
			// var sPosition:Number3D = object3d.scenePosition;
			a_global.transform(a_global,a_obj.parent.inverseSceneTransform);
//			
//			trace(a_global);
			
			return a_global;
		}
	}
}
