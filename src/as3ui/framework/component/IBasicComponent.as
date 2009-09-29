package as3ui.framework.component
{
	import as3ui.framework.IDisplayObject;
	
	public interface IBasicComponent extends IDisplayObject
	{
		function setData(data:Object):void
		function show():void
		function hide():void
		function dispose():void;
				
	}
}