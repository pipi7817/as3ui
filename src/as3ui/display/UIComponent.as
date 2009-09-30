package as3ui.display
{
	import as3ui.events.UIEvent;
	import as3ui.framework.component.IBasicComponent;
	
	import flash.events.Event;
	public class UIComponent extends UISprite implements IDisposable, IDrawable, IBasicComponent
	{
		
		protected var m_changed:Boolean = false;
		protected var m_debug:Boolean = false;

				
		public function UIComponent()
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
			if( !UIComponentManager.isInited )
			{
				UIComponentManager.init(stage);	
			}
			
			UIComponentManager.addEventListener(UIEvent.RENDER, handleRenderStage,false,0,true);

			if(hasChanged())
			{
				redraw();
//				requestRedraw();
			}
		}
		
		private function handleRemovedFromStage(a_event:Event):void
		{
			UIComponentManager.removeEventListener(UIEvent.RENDER, handleRenderStage);
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
		// PUBLIC
		///////////////////////////////////////////////////////////////////////
		override public function setSize(a_width:Number=NaN, a_height:Number=NaN, a_pixelSnap:Boolean=false):void
		{
			if(a_width != width || a_height != height)
			{
				super.setSize(a_width,a_height,a_pixelSnap);
				setChanged();
			}
			else
			{
				super.setSize(a_width,a_height,a_pixelSnap);
			}
		}
		
		public function setData(a_data:Object):void
		{

		}

		public function redraw():void {
			draw();
			clearChanged();				
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			UIComponentManager.removeEventListener(UIEvent.RENDER, handleRenderStage);
			super.dispose();
		}	
	}
}