/**
 * @author Alexander Aivars (alexander.aivars@gmail.com)
 * 
 * Base Button Class based on com.lessrain.as3lib.controls.button by Luis Martinez (Less Rain)
 */
package se.konstruktor.as3ui.controls.button
{
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	
	import se.konstruktor.as3ui.UIObject;
	import se.konstruktor.as3ui.managers.IFocusObject;
	
	public class BaseButton extends UIObject implements IFocusObject
	{

		protected var m_useHandCursor			:	Boolean			=   true;
		protected var m_doubleClick				:	Boolean			=   false;

		protected var m_doubleClickEvent		:   ButtonEvent;
		protected var m_releaseEvent			:   ButtonEvent;
		protected var m_releaseOutsideEvent		:   ButtonEvent;
		protected var m_pressEvent				:   ButtonEvent;
		protected var m_rollOverEvent			:   ButtonEvent;
		protected var m_rollOutEvent			:   ButtonEvent;
		protected var m_rollOutWhileDownEvent	:   ButtonEvent;
		protected var m_rollOverWhileDownEvent	:   ButtonEvent;
		protected var m_enabledEvent			:   ButtonEvent;
		protected var m_disabledEvent			:   ButtonEvent;
		protected var m_stateEvent				:	ButtonEvent;
		protected var m_toggledEvent			:	ButtonEvent;
		
		internal var m_isMouseOver				:	Boolean;
		internal var m_enabled					:	Boolean;
		internal var m_isFocus					:	Boolean;
		internal var m_toggled					:	Boolean;
		internal var m_state					:	String;
		
		public function BaseButton()
		{
			super();
			initialize();
		}
		
		protected function setMouseOver(a_value:Boolean):void
		{
			m_isMouseOver = a_value;
		}	

		public function get isMouseOver():Boolean
		{
			return m_isMouseOver;
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
		
		public function get isEnabled():Boolean
		{
			return m_enabled;
		}
				
		public function set toggled(a_toggled:Boolean):void
		{
			var oldToggled	:	Boolean	=	m_toggled;
			m_toggled					=	a_toggled;
			
			if(oldToggled != a_toggled)
			{
				dispatchEvent(m_toggledEvent);
			}			
		}
		
		public function get toggled():Boolean
		{
			return m_toggled;
		}
		
		
		public function setFocus(a_isFocus:Boolean = true):void
		{
			var oldFocus	:	Boolean	=	m_isFocus;
			m_isFocus					=	a_isFocus;
			
			if(oldFocus != a_isFocus)
			{
//				dispatchEvent(m_focusEvent);
			}
		}
		
		public function get isFocus():Boolean
		{
			return m_isFocus;
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

		private function initialize():void
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

		private function finalize():void
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
			if(stage)
			{
				stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler,false,0,true);
			}
		}

		private function removeStageListener():void
		{
			if(stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
			}
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
					state = m_isMouseOver?ButtonState.OVER:ButtonState.RELEASED;
					dispatchEvent(m_releaseEvent);
				}
				else
				{
					state = ButtonState.OVER
					dispatchEvent(m_rollOverEvent);
				}
			}			
		}

		protected function rollOverHandler(m_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_isMouseOver = true;
				if(!m_event.buttonDown) 
				{
					state = ButtonState.OVER
					dispatchEvent(m_rollOverEvent);
				}
				else
				{
					if(m_isFocus)
					{
						state = ButtonState.PRESSED;
						dispatchEvent(m_rollOverWhileDownEvent);
					}
				}
			}
		}

		protected function rollOutHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_isMouseOver = false;
				state = ButtonState.RELEASED
				if(!a_event.buttonDown)
				{
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
			if(m_enabled)
			{
				m_isFocus = false;
				state = ButtonState.RELEASED;
				dispatchEvent(m_releaseOutsideEvent);
			}

			removeStageListener();

		}
		
		protected function removeButtonHandler(a_event:Event):void
		{
			finalize();
		}
		

	}
}