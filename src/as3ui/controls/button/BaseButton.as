 /**
 * @author Alexander Aivars (alexander.aivars(at)gmail.com)
 * 
 * Base Button Class based on com.lessrain.as3lib.controls.button by Luis Martinez (Less Rain)
 */
package as3ui.controls.button
{
	import as3ui.display.UISprite;
	
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
	[Event (name="click", type="as3ui.controls.button.ButtonEvent")]
			
	public class BaseButton extends UISprite
	{

		/**********************************************************************
		 * MEMBER VARIABLES
		 * *******************************************************************/	
		protected var m_useHandCursor			:	Boolean			=   true;
		protected var m_doubleClick				:	Boolean			=   false;
		protected var m_isToggleButton			:	Boolean;
		protected var m_isStickyButton			:	Boolean;

		protected var m_doubleClickEvent		:   ButtonEvent;
		protected var m_clickEvent				:   ButtonEvent;
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
		internal var m_pendingState				:	String;
		internal var m_bindKey					:	uint;


		/**********************************************************************
		 * CONSTRUCTOR
		 * *******************************************************************/	
		public function BaseButton()
		{
			super();
			initialize();
		}
		
		
		/**********************************************************************
		 * INITIALIZE AND SETUP
		 * *******************************************************************/	
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


			m_state = ButtonState.OUT;
			setEnabled( m_enabled );
			
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
			m_clickEvent				=	new ButtonEvent(ButtonEvent.CLICK,true,true);
		}
		
		private function initializeButtonListeners():void
		{
			if(doubleClickEnabled)
			{
				addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler, false,0,true); 
			}
			
			initializeKeyListeners();
			
			addEventListener(MouseEvent.MOUSE_DOWN, pressHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP, releaseHandler,false,0,true); 
			addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler,false,0,true);
			addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler,false,0,true);
			addEventListener(MouseEvent.CLICK, clickHandler,false,0,true);

		}
		
		private function initializeKeyListeners():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler,false,0,true);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler,false,0,true);
		}

				
		/**
		 * 
		 * @return 
		 * Gets or sets a value that indicates the current ButtonState of the component.
		 */		
		private function getCurrentState():String
		{
			return m_state;
		}
		

		/**
		 * 
		 * @return 
		 * Gets or sets a value that indicates the current ButtonState of the component.
		 */	
		private function setCurrentState(a_state:String):void
		{

			var oldState 	: 	String	= m_state;
			if(m_toggled)
			{
				m_pendingState = a_state;
			}
			else if ( oldState != a_state )
			{
				m_state = a_state;
				dispatchEvent(m_stateEvent);
			}
		}

		private function setMouseOver(a_value:Boolean):void
		{
			m_isMouseOver = a_value;
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
		

		/**********************************************************************
		 * PRIVATE
		 * *******************************************************************/	
		private function addButtonHandlers(a_event:Event):void
		{
//			if(a_event.target != this) return;
			initializeButtonListeners();
			//finalize();
		}


		private function removeButtonHandlers(a_event:Event):void
		{
//			if(a_event.target != this) return;
			removeButtonListeners();
			//finalize();
		}

		private function setEnabled(a_enabled:Boolean):void
		{

			var oldEnabled	:	Boolean	=	m_enabled;
			m_enabled					=	a_enabled;
			mouseEnabled				=	a_enabled;
			if(stage)
			{
				if(oldEnabled != a_enabled)
				{
					if(a_enabled) 
					{
						dispatchEvent(m_enabledEvent);
						// reset state
						setCurrentState(ButtonState.OUT);
						dispatchEvent(m_rollOutEvent);
					}
					else
					{
						setCurrentState(ButtonState.DISABLED);
						dispatchEvent(m_disabledEvent);
					}
				}
			}
			else
			{
				m_state = a_enabled?ButtonState.OUT:ButtonState.DISABLED;
			}
		}

		/**********************************************************************
		 * EVENT HANDLERS
		 * *******************************************************************/	
		private function keyDownHandler(a_event:KeyboardEvent):void
		{
			if(m_bindKey != 0 && m_bindKey == a_event.keyCode)
			{
				pressHandler();
			}
		}

		private function keyUpHandler(a_event:KeyboardEvent):void
		{
			if(m_bindKey != 0 && m_bindKey == a_event.keyCode)
			{
				releaseHandler();
			}
		}
		
		private function stageMouseUpHandler(a_event:MouseEvent):void
		{
			if(a_event.eventPhase>=EventPhase.AT_TARGET) releaseOutsideHandler();
			return;			
		}
		
		private function pressHandler(a_event:MouseEvent = null):void
		{
			if(m_enabled)
			{				
				m_isFocus = true;
				setCurrentState(ButtonState.PRESSED);
				if(a_event)
				{
					addStageMouseEventListener();
				}
				dispatchEvent(m_pressEvent);
				
				onPress();
			}

			if(m_isToggleButton)
			{
				toggled = !toggled;
			}
		}

		private function doubleClickHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{ 
				dispatchEvent(m_doubleClickEvent);
				onDoubleClick();
			}
		}

		private function clickHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{ 
				dispatchEvent(m_clickEvent);
				onClick();
			}
		}


		private function releaseHandler(a_event:MouseEvent = null):void
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
					setCurrentState(m_isMouseOver?ButtonState.OVER:ButtonState.OUT);
					dispatchEvent(m_releaseEvent);
				}
				else
				{
					setCurrentState(ButtonState.OVER);
					dispatchEvent(m_rollOverEvent);
				}
				
				onRelease();
			}			
		}

		private function rollOverHandler(m_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_isMouseOver = true;
				if(m_event.buttonDown) 
				{
					if(m_isFocus)
					{
						setCurrentState(ButtonState.PRESSED);
						dispatchEvent(m_rollOverWhileDownEvent);
					}
				}
				else
				{
					setCurrentState(ButtonState.OVER);
					dispatchEvent(m_rollOverEvent);
				}
				
				onRollOver();
			}
		}

		private function rollOutHandler(a_event:MouseEvent):void
		{
			if(m_enabled)
			{
				m_isMouseOver = false;
				if(a_event.buttonDown)
				{
					if(!m_isStickyButton)
					{
						setCurrentState(ButtonState.OUT);
					}
					if(m_isFocus)
					{
						dispatchEvent(m_rollOutWhileDownEvent);
					}
				}
				else
				{
					setCurrentState(ButtonState.OUT);
					dispatchEvent(m_rollOutEvent);
				}

				onRollOut();

			}
		}		
		
		private function releaseOutsideHandler():void
		{
			if(m_enabled)
			{
				m_isFocus = false;
				setCurrentState(ButtonState.OUT);
				dispatchEvent(m_releaseOutsideEvent);
				onReleaseOutside();
			}

			removeStageMouseEventListener();
		}
		

		/**********************************************************************
		 * PROTECTED INTERFACE METHODS
		 * *******************************************************************/	
		protected function onPress():void {}
		protected function onDoubleClick():void {}
		protected function onClick():void {}
		protected function onRelease():void {}
		protected function onRollOver():void {}
		protected function onRollOut():void {}
		protected function onReleaseOutside():void {}
		protected function onToggled():void {}


		/**********************************************************************
		 * DISPOSE AND DESTROY
		 * *******************************************************************/	
		override public function dispose():void
		{
			removeButtonListeners();

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
			m_clickEvent				= null;

			super.dispose();
		}
		
		private function removeButtonListeners():void
		{
			removeStageMouseEventListener();

			if(hasEventListener(MouseEvent.DOUBLE_CLICK)) 
			{
				removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			}
			
			if(stage)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
				stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpHandler);				
			}
			
			removeEventListener(MouseEvent.MOUSE_DOWN, pressHandler);
			removeEventListener(MouseEvent.MOUSE_UP, releaseHandler); 
			removeEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
			removeEventListener(MouseEvent.CLICK, clickHandler);

		}		

		/**********************************************************************
		 * PUBLIC ACCESSORS AND SETTERS
		 * *******************************************************************/
		public function set key(a_uint:uint):void
		{
			if(m_bindKey == a_uint) return;
			else m_bindKey = a_uint;
		}

		public function get key():uint
		{
			return m_bindKey;
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
		public function set enabled(a_value:Boolean):void
		{
			setEnabled(a_value);			
		}
		
		/**
		 * 
		 * @return 
		 * Gets a value that indicates whether the component can accept user input.
		 */		
		public function get enabled():Boolean
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

				if(!a_toggled && m_state != m_pendingState)
				{
					setCurrentState(m_pendingState);
				}	
				
				onToggled();
			}
			
		}
		
		public function get toggled():Boolean
		{
			return m_toggled;
		}
		
		public function set isToggleButton(a_value:Boolean):void
		{
			m_isToggleButton = a_value;
		}
		
		public function set isStickyButton(a_value:Boolean):void
		{
			m_isStickyButton = a_value;
		}
		
		public function setFocus(a_isFocus:Boolean = true):void
		{
//			var oldFocus	:	Boolean	=	m_isFocus;
			m_isFocus					=	a_isFocus;
//			if(oldFocus != a_isFocus)
//			{
//				dispatchEvent(m_focusEvent);
//			}
		}
		
		public function get isFocus():Boolean
		{
			return m_isFocus;
		}
				
		public function get state():String
		{
			return getCurrentState();
		}
	}
}