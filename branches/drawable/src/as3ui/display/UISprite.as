/**
* @author Alexander Aivars (alexander.aivars(at)gmail.com)
*/
package as3ui.display
{
	import as3ui.events.UIEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	[Event (name="resize", type="as3ui.events.UIEvent")]
	[Event (name="move", type="as3ui.events.UIEvent")]
	[Event (name="moveComplete", type="as3ui.events.UIEvent")]
	[Event (name="show", type="as3ui.events.UIEvent")]
	[Event (name="showComplete", type="as3ui.events.UIEvent")]
	[Event (name="hide", type="as3ui.events.UIEvent")]
	[Event (name="hideComplete", type="as3ui.events.UIEvent")]
	public class UISprite extends Sprite implements IDisposable
	{
		protected var m_maxWidth		:	Number;
		protected var m_minWidth		:	Number = 0;
		protected var m_maxHeight		:	Number;
		protected var m_minHeight		:	Number = 0;
		protected var m_visibleHeight	:	Number;
		protected var m_visibleWidth	:	Number;
		protected var m_xpos			:	Number;
		protected var m_ypos			:	Number;
		protected var m_autosize		:	Boolean;
		
		public function UISprite()
		{
			super();
			if(m_autosize)
			{
				addEventListener(Event.ADDED,onAdded,false,0,true);
				addEventListener(Event.REMOVED,onRemoved,false,0,true);
			}
		}

		private function onAdded( a_event:Event ):void
		{
			if(a_event.target != this) return;
			parent.removeEventListener(UIEvent.RESIZE,parentResize);
			parent.addEventListener(UIEvent.RESIZE,parentResize,false,0,true);
		}
		
		private function onRemoved( a_event:Event ):void
		{
			if(a_event.target != this) return;
			parent.removeEventListener(UIEvent.RESIZE,parentResize);
		}
		
		public function move(a_x:Number,a_y:Number, a_pixelSnap:Boolean = false):void
		{
			var oldX:Number = m_xpos;
			var oldY:Number = m_ypos;
			
			m_xpos = a_x;
			m_ypos = a_y;
			
			if(a_pixelSnap)
			{
				this.x = Math.round(m_xpos);
				this.y = Math.round(m_ypos);
			}
			else 
			{
				this.x = m_xpos;
				this.y = m_ypos;				
			}
			
			if(oldX != this.x || oldY != this.y)
			{
				dispatchEvent(new UIEvent(UIEvent.MOVE,true,true));
				moveComplete();
			}
		}

		protected function moveComplete():void
		{
			dispatchEvent(new UIEvent(UIEvent.MOVE_COMPLETE,true,true));
		}


		protected function parentResize( a_event:Event = null):void
		{
			if( width != parent.width || height != parent.height )
			{
				setSize(parent.width,parent.height);
			}
		}

		public function show():void
		{
			
			dispatchEvent(new UIEvent(UIEvent.SHOW,true,true));
			showComplete();	
		}

		protected function showComplete():void
		{
//			if(!visible)
//			{
				visible = true;
				dispatchEvent(new UIEvent(UIEvent.SHOW_COMPLETE,true,true));
//			}
		}

		public function hide():void
		{
			if(visible)
			{
				dispatchEvent(new UIEvent(UIEvent.HIDE,true,true));
				hideComplete();
			}
		}
		
		protected function hideComplete():void
		{
			visible = false;
			dispatchEvent(new UIEvent(UIEvent.HIDE_COMPLETE,true,true));
		}


		public function setSize(a_width:Number = NaN, a_height:Number = NaN, a_pixelSnap:Boolean = false):void
		{
			var newWidth:Number;
			var newHeight:Number;

			if(isNaN(a_width))
			{
				a_width = super.width;
			}

			if(isNaN(a_height))
			{
				a_height = super.height;
			}

			if( a_pixelSnap )
			{
				a_height = Math.round( a_height );
				a_width = Math.round( a_width );
			}

			if ( isNaN(m_maxWidth) )
			{
				newWidth = Math.max(a_width,m_minWidth);
			}
			else
			{
				newWidth = Math.max(Math.min(a_width,m_maxWidth),m_minWidth);
			}
			
			if ( isNaN(m_maxHeight) )
			{
				newHeight = Math.max(a_height,m_minHeight);
			}
			else
			{
				newHeight = Math.max(Math.min(a_height,m_maxHeight),m_minHeight);
			}
	
	
			if( newWidth != m_visibleWidth || newHeight != m_visibleHeight )
			{
				m_visibleWidth = newWidth;	
				m_visibleHeight = newHeight;
				dispatchEvent(new UIEvent(UIEvent.RESIZE,true,true));
			}
		}
		
		public function setMaxSize(a_maxWidth:Number = NaN, a_maxHeight:Number = NaN):void
		{
			if(!isNaN(a_maxWidth)) { m_maxWidth = a_maxWidth; }
			if(!isNaN(a_maxHeight)) { m_maxHeight = a_maxHeight; }
		}
		
		public function setMinSize(a_minWidth:Number = NaN, a_minHeight:Number = NaN):void
		{
			if(!isNaN(a_minWidth)) { m_minWidth = a_minWidth; }
			if(!isNaN(a_minHeight)) { m_minHeight = a_minHeight; }
		}

		override public function get height():Number 
		{
			if( isNaN(m_visibleHeight) )
			{
				return super.height;
			}
			else
			{
				return m_visibleHeight
			}
		}

		override public function get width():Number 
		{
			if( isNaN(m_visibleWidth) )
			{
				return super.width;
			}
			else
			{
				return m_visibleWidth
			}
		}


		public function set right(a_value:Number):void
		{
			x = a_value - width;
		}

		public function get right():Number
		{
			return x + width;
		}

		public function set bottom(a_value:Number):void
		{
			y = a_value - height;
		}

		public function get bottom():Number
		{
			return y + height;
		}

		public function set globalX(value:Number):void
		{
			m_xpos = x = x + value-stage.globalToLocal(localToGlobal(new Point(0,0) )).x;

		}
	
		public function set globalY(value:Number):void
		{
			m_ypos = y = y + value-stage.globalToLocal(localToGlobal(new Point(0,0) )).y;
		}

		public function get globalX():Number
		{
			return stage.globalToLocal(localToGlobal(new Point(0,0) )).x;
		}
	
		public function get globalY():Number
		{
			return stage.globalToLocal(localToGlobal(new Point(0,0) )).y;
		}

		public function dispose():void
		{
			if(parent)
			{
				parent.removeEventListener(UIEvent.RESIZE,parentResize);
			}

			var child:DisplayObject;
			while(numChildren>0)
			{
				child = removeChildAt(0);
				if(child is IDisposable)
				{
					(child as IDisposable).dispose();
				}
			}
			child = null;
			
			removeEventListener(Event.ADDED,onAdded);
			removeEventListener(Event.REMOVED,onRemoved);
		}			
		
	}
}