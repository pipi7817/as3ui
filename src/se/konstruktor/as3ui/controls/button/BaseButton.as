/**
 * @author Alexander Aivars (alexander.aivars@gmail.com)
 * 
 * Base Button Class based on com.lessrain.as3lib.controls.button by Luis Martinez (Less Rain)
 */
package se.konstruktor.as3ui.controls.button
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;

	public class BaseButton extends Sprite
	{

		protected var m_useHandCursor			:	Boolean			=   true;
		protected var m_doubleClick				:	Boolean			=   false;

		private var m_doubleClickEvent			:   ButtonEvent;
		private var m_releaseEvent				:   ButtonEvent;
		private var m_releaseOutsideEvent		:   ButtonEvent;
		private var m_pressEvent				:   ButtonEvent;
		private var m_rollOverEvent				:   ButtonEvent;
		private var m_rollOutEvent				:   ButtonEvent;
		private var m_rollOutWhileDownEvent		:   ButtonEvent;
		private var m_rollOverWhileDownEvent	:   ButtonEvent;
		private var m_enabledEvent				:   ButtonEvent;
		private var m_disabledEvent				:   ButtonEvent;
		private var m_stateEvent				:	ButtonEvent;
		private var m_toggledEvent				:	ButtonEvent;
		
		internal var m_enabled					:	Boolean;
		internal var m_isFocus					:	Boolean;
		internal var m_toggled					:	Boolean;
		internal var m_mouseIsOver				:	Boolean;
		internal var m_state					:	String;
		
		public function BaseButton()
		{
			super();
//			graphics.beginFill(0x00FF00,1);
//			graphics.drawRect(0,0,100,24);
//			graphics.endFill();
			initialize();
		}
		
		public function getEnabled():Boolean
		{
			return m_enabled;
		}
		
		public function setEnabled(a_enabled:Boolean):void
		{
			var oldEnabled	:	Boolean	=	m_enabled;
			m_enabled					=	a_enabled;
			mouseEnabled				=	a_enabled;
			
			if(oldEnabled != a_enabled)
			{
				if(a_enabled) 
				{
					dispatchEvent(m_enabledEvent);
					// reset state
					state = ButtonState.RELEASED;
					dispatchEvent(m_rollOutEvent);
				}
				else
				{
					state = ButtonState.DISABLED;
					dispatchEvent(m_disabledEvent);
				}
			}
		}
		
		public function setToggled(a_toggled:Boolean):void
		{
			var oldToggled	:	Boolean	=	m_toggled;
			m_toggled					=	a_toggled;
			
			if(oldToggled != a_toggled)
			{
				dispatchEvent(m_toggledEvent);
			}			
		}
		
		public function get isToggled():Boolean
		{
			return m_toggled;
		}
		
		protected function get state():String
		{
			return m_state;
		}
		
		protected function set state(a_state:String):void
		{
			var oldState 	: 	String	= m_state;

			if(oldState != a_state && !m_toggled)
			{
				m_state = a_state;
				dispatchEvent(m_stateEvent);
			}
		}

		protected function initialize():void
		{
			if(m_useHandCursor)
			{
				buttonMode = m_useHandCursor; 
				useHandCursor = m_useHandCursor;
			}
			
			if(m_doubleClick)
			{
				doubleClickEnabled = m_doubleClick;
			}
			
			m_state = ButtonState.RELEASED;
			
			initializeEvents();
			
			setEnabled(true);
		}
		
		
		
		private function initializeEvents():void
		{

			m_doubleClickEvent			=	new ButtonEvent(ButtonEvent.DOUBLE_CLICK,true,true);
			m_releaseEvent				=	new ButtonEvent(ButtonEvent.RELEASE,true,true);
			m_releaseOutsideEvent		=	new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE,true,true);
			m_pressEvent				=	new ButtonEvent(ButtonEvent.PRESS,true,true);
			m_rollOverEvent				=	new ButtonEvent(ButtonEvent.ROLL_OVER,true,true);
			m_rollOutEvent				=	new ButtonEvent(ButtonEvent.ROLL_OUT,true,true);
			m_rollOutWhileDownEvent		=	new ButtonEvent(ButtonEvent.ROLL_OUT_WHILE_DOWN,true,true);
			m_rollOverWhileDownEvent	=	new ButtonEvent(ButtonEvent.ROLL_OVER_WHILE_DOWN,true,true);
			m_enabledEvent				= 	new ButtonEvent(ButtonEvent.ENABLED,true,true);
			m_disabledEvent				=	new ButtonEvent(ButtonEvent.DISABLED,true,true);
			m_stateEvent				=	new ButtonEvent(ButtonEvent.CHANGE_STATE,true,true);
			m_toggledEvent				= 	new ButtonEvent(ButtonEvent.TOGGLE,true,true);
			
			addButtonListeners();

		}
		
		private function addButtonListeners():void
		{
			if(doubleClickEnabled)
			{
				addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler, false,0,true); 
			}
			
			addEventListener(MouseEvent.MOUSE_DOWN, pressHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP, releaseHandler,false,0,true); 
			addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler,false,0,true);
			addEventListener(Event.REMOVED, removeButtonHandler,false,0,true);			
			
		}

		private function removeButtonListeners():void
		{
			if(hasEventListener(MouseEvent.DOUBLE_CLICK)) 
			{
				removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			}
			
			removeEventListener(MouseEvent.MOUSE_DOWN, pressHandler);
			removeEventListener(MouseEvent.MOUSE_UP, releaseHandler); 
			removeEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
			removeEventListener(Event.REMOVED, removeButtonHandler);
			
		}
		
		
		private function addStageListener():void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler,false,0,true);
		}

		private function removeStageListener():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
		}
		
		private function stageMouseUpHandler(a_event:MouseEvent):void
		{
			if(a_event.eventPhase>=EventPhase.AT_TARGET) releaseOutsideHandler();
			return;			
		}
		
		protected function pressHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_isFocus = true;
				state = ButtonState.PRESSED;
				addStageListener();
				dispatchEvent(m_pressEvent);
			}
		}

		protected function doubleClickHandler(a_event:MouseEvent):void
		{
			if(m_enabled) dispatchEvent(m_doubleClickEvent);
		}


		protected function releaseHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{
				
				removeStageListener();
				
				if(m_isFocus)
				{
					m_isFocus = false;
					
					state = m_mouseIsOver?ButtonState.OVER:ButtonState.RELEASED;
					dispatchEvent(m_releaseEvent);
				}
				else
				{
					dispatchEvent(m_rollOverEvent);
				}
			}			
		}

		protected function rollOverHandler(m_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_mouseIsOver = true;
				if(!m_event.buttonDown) 
				{
					state = ButtonState.OVER
					dispatchEvent(m_rollOverEvent);
					
				}
				else
				{
					if(m_isFocus)
					{
						dispatchEvent(m_rollOverWhileDownEvent);
					}
				}
			}
		}

		protected function rollOutHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_mouseIsOver = false;
				if(!a_event.buttonDown)
				{
					state = ButtonState.RELEASED
					dispatchEvent(m_rollOutEvent);
				}
				else
				{
					if(m_isFocus)
					{
						dispatchEvent(m_rollOutWhileDownEvent);
					}
				}
			}
		}		
		
		protected function releaseOutsideHandler():void
		{
			m_isFocus = false;
			state = ButtonState.RELEASED;
			removeStageListener();
			dispatchEvent(m_releaseOutsideEvent);
		}
		
		protected function removeButtonHandler(a_event:Event):void
		{
			finalize();
		}
		
		protected function finalize():void
		{
			removeStageListener();
			
			m_doubleClickEvent			= null;
			m_releaseEvent				= null;
			m_releaseOutsideEvent		= null;
			m_pressEvent				= null;
			m_rollOverEvent				= null;
			m_rollOutEvent				= null;
			m_rollOutWhileDownEvent		= null;
			m_rollOverWhileDownEvent	= null;
			m_enabledEvent				= null;
			m_disabledEvent				= null;
			m_stateEvent				= null;
			m_toggledEvent				= null;
			
			removeButtonListeners();
		}
	}
}