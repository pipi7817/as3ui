package as3ui.display
{
	import as3ui.events.UIEvent;
	
	import flash.events.Event;
	
	public class UIComponent extends UISprite implements IDisposable, IDrawable
	{
		
		protected var m_changed:Boolean = false;
		
		public function UIComponent()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage,false,0,true);

			with(graphics)
			{
				beginFill(0xFF0000,1);
				drawRect(0,0,600,600);
				endFill();
			}
			
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
			with(graphics)
			{
				beginFill(0x00FF00,1);
				drawRect(0,0,300,300);
				endFill();
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
		public function redraw():void {
			draw();
			clearChanged();				
		}
		
		override public function dispose():void
		{
			super.dispose();

			while(numChildren>0)
			{
				removeChildAt(0);
			}

			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
			UIComponentManager.removeEventListener(UIEvent.RENDER, handleRenderStage);
			
		}	
	}
}