/**
* @author Alexander Aivars <alex(at)kramgo.com>
*/

package as3ui.framework.component
{
	import as3ui.display.IDisposable;
	import as3ui.display.IDrawable;
	import as3ui.display.UISprite;
	import as3ui.events.UIEvent;
	import as3ui.framework.componentmanager.ComponentManager;
	import as3ui.framework.componentmanager.ns_component_manager;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;

	public class BasicComponent extends UISprite implements IDisposable, IDrawable, IBasicComponent
	{
		
		///////////////////////////////////////////////////////////////////////
		// NAMESPACE
		///////////////////////////////////////////////////////////////////////
		use namespace ns_component_manager;

		
		///////////////////////////////////////////////////////////////////////
		// MEMBER VARIABLES 
		///////////////////////////////////////////////////////////////////////
		private var m_changed:Boolean = false;
		private var m_componentInfo:BasicComponentInfo = new BasicComponentInfo();

		protected var m_debug:Boolean = false;
		

		///////////////////////////////////////////////////////////////////////
		// CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////
		public function BasicComponent()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage,false,0,true);
			setChanged();
		}
		
		
		///////////////////////////////////////////////////////////////////////
		// PROTECTED 
		///////////////////////////////////////////////////////////////////////

		protected function setChanged():void
		{
			m_changed = true;
			requestRedraw();
		}

		protected function hasChanged():Boolean
		{
			return m_changed;	
		}

		protected function requestRedraw(a_event:Event = null ):void
		{
			if (stage != null) {
				stage.invalidate();
			}	
		}

		protected function draw():void
		{
			if(m_debug)
			{
				with(graphics)
				{
					beginFill(0xFFF000,1);
					drawRect(0,0,width,height);
					drawRect(1,1,width-2,height-2);

					beginFill(0xCCCCCC,0);
					drawRect(1,1,width-2,height-2);
					endFill();
				}
			}
		}
		
		protected function clearChanged():void
		{
			m_changed = false;
		}


		///////////////////////////////////////////////////////////////////////
		// EVENT HANDLERS
		///////////////////////////////////////////////////////////////////////
		private function handleAddedToStage(a_event:Event):void
		{
			if( !ComponentManager.isInited )
			{
				ComponentManager.init(stage);	
			}
			
			ComponentManager.addEventListener(UIEvent.RENDER, handleRenderStage,false,0,true);

			if(hasChanged())
			{
				redraw();
//				requestRedraw();
			}
		}
		
		private function handleRemovedFromStage(a_event:Event):void
		{
			ComponentManager.removeEventListener(UIEvent.RENDER, handleRenderStage);
		}
		
		private function handleRenderStage(a_event:Event):void
		{
			if (hasChanged()) {
	            if (stage == null) {
                    // received render, but the stage is not available, so we will wait for addedToStage:
	            }
				else
				{
					redraw();
				}
			}
		}


		///////////////////////////////////////////////////////////////////////
		// PUBLIC INTERFACE
		///////////////////////////////////////////////////////////////////////
		public function redraw():void {
			draw();
			clearChanged();				
		}

		public function setData(a_data:Object):void { throw new IllegalOperationError("Abstract method \"setData\": must be overridden in a subclass"); }
		
		
		///////////////////////////////////////////////////////////////////////
		// IDISPOSE
		///////////////////////////////////////////////////////////////////////
		override public function dispose():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			ComponentManager.removeEventListener(UIEvent.RENDER, handleRenderStage);
			super.dispose();
		}	
		

		///////////////////////////////////////////////////////////////////////
		// ACCESSORS
		///////////////////////////////////////////////////////////////////////
		public function get componentInfo():BasicComponentInfo
		{
			return m_componentInfo;
		}
		
		
	}
}