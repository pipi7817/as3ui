  /**
 * @author Alexander Aivars (alexander.aivars(at)gmail.com)
 * 
 * Base Button Class based on com.lessrain.as3lib.controls.button by Luis Martinez (Less Rain)
 */
package as3ui.controls.button
{
	import as3ui.UIObject;
	import as3ui.managers.IFocusObject;
	
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	[Event (name="double_click", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="release", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="release_outside", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="press", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="roll_over", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="roll_out", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="roll_out_while_down", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="roll_over_while_down", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="enabled", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="disabled", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="change_state", type="as3ui.controls.button.ButtonEvent")]
	[Event (name="toggle", type="as3ui.controls.button.ButtonEvent")]
			
	public class BaseButton extends UIObject implements IFocusObject
	{

		protected var m_useHandCursor			:	Boolean			=   true;
		protected var m_doubleClick				:	Boolean			=   false;
		protected var m_isToggleButton			:	Boolean;

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
		internal var m_enabled					:	Boolean			=	true;
		internal var m_isFocus					:	Boolean;
		internal var m_toggled					:	Boolean;
		internal var m_state					:	String;
		internal var m_bindKey					:	uint;
				
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
		
		/**
		 * 
		 * @param a_enabled
		 * Sets whether the component can accept user input.
		 */				
		public function setEnabled(a_enabled:Boolean):void
		{

			var oldEnabled	:	Boolean	=	m_enabled;
			m_enabled					=	a_enabled;
			mouseEnabled				=	a_enabled;
			if(!stage)
			{
				m_state = a_enabled?ButtonState.RELEASED:ButtonState.DISABLED;
			}
			else
			{
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
		}
		
		/**
		 * 
		 * @return 
		 * Gets a value that indicates whether the component can accept user input.
		 */		
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
				
		/**
		 * 
		 * @return 
		 * Gets or sets a value that indicates the current ButtonState of the component.
		 */		
		protected function get state():String
		{
			return m_state;
		}
		

		/**
		 * 
		 * @return 
		 * Gets or sets a value that indicates the current ButtonState of the component.
		 */	
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
			setEnabled(m_enabled);
			
			initializeEvents();

			addEventListener(Event.ADDED_TO_STAGE,addButtonHandlers,false,0,true);	
			addEventListener(Event.REMOVED_FROM_STAGE, removeButtonHandlers,false,0,true);			


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
			
		}

		private function finalize():void
		{
			
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
			
			
		}
		
		private function addButtonListeners():void
		{
			if(doubleClickEnabled)
			{
				addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler, false,0,true); 
			}

			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp,false,0,true);
			
			addEventListener(MouseEvent.MOUSE_DOWN, pressHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP, releaseHandler,false,0,true); 
			addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler,false,0,true);
		}

		public function bindKey(a_uint:uint):void
		{
			if(m_bindKey == a_uint) return;
			else m_bindKey = a_uint;
		}
		
		private function addStageListners(a_event:Event = null) : void
		{
			if(a_event.target != this) return;
			
		}

		private function removeButtonListeners():void
		{
			removeStageMouseEventListener();

			if(hasEventListener(MouseEvent.DOUBLE_CLICK)) 
			{
				removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			}

			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);				

			removeEventListener(MouseEvent.MOUSE_DOWN, pressHandler);
			removeEventListener(MouseEvent.MOUSE_UP, releaseHandler); 
			removeEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
		}
				
		private function onKeyDown(a_event:KeyboardEvent):void
		{
			if(m_bindKey != 0 && m_bindKey == a_event.keyCode)
			{
				pressHandler();
			}
		}

		private function onKeyUp(a_event:KeyboardEvent):void
		{
			if(m_bindKey != 0 && m_bindKey == a_event.keyCode)
			{
				releaseHandler();
			}
			
		}
		
		private function addStageMouseEventListener():void
		{
			if(stage)
			{
				stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler,false,0,true);
			}
		}

		private function removeStageMouseEventListener():void
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
		
		protected function pressHandler(a_event:MouseEvent = null):void
		{
			if(m_enabled)
			{				
				m_isFocus = true;
				state = ButtonState.PRESSED;
				if(a_event != null)
				{
					addStageMouseEventListener();
				}
				dispatchEvent(m_pressEvent);
			}

			if(m_isToggleButton)
			{
				toggled = !toggled;
			}
		}

		protected function doubleClickHandler(a_event:MouseEvent):void
		{
			if(m_enabled) dispatchEvent(m_doubleClickEvent);
		}


		protected function releaseHandler(a_event:MouseEvent = null):void
		{
			if(m_enabled)
			{
				if(a_event != null)
				{
					removeStageMouseEventListener();
				}
				
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

			removeStageMouseEventListener();

		}
		

		protected function addButtonHandlers(a_event:Event):void
		{
//			if(a_event.target != this) return;
			addButtonListeners();
			//finalize();
		}


		protected function removeButtonHandlers(a_event:Event):void
		{
//			if(a_event.target != this) return;
			removeButtonListeners();
			//finalize();
		}
		
	}
}