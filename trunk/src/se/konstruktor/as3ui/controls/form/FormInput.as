package se.konstruktor.as3ui.controls.form {
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import se.konstruktor.as3ui.UIObject;
	import se.konstruktor.as3ui.controls.input.BaseInput;
	
	
	public class FormInput extends UIObject implements IFormField 
	{
		protected var m_id:String;
		protected var m_data:*;
		protected var m_value:String;
		protected var m_defaultValue:String;
		protected var m_input:BaseInput;
		protected var m_isEmail:Boolean;
		protected var m_isFocus:Boolean;
		
		public function FormInput(a_input:BaseInput ,a_id:String="",a_isEmail:Boolean = false,a_isPassword:Boolean = false,a_canBeEmpty:Boolean = false, m_autoFocus:Boolean = false )
		{
			m_id = a_id;
			m_value = a_input.value;
			m_input = a_input;
			m_isEmail = a_isEmail;
			m_defaultValue = "";
			
			a_input.textfield.displayAsPassword = a_isPassword;
			
			addChild(a_input);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			setSize();

		} 
		
		private function onAddedToStage(event:Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(MouseEvent.CLICK,onClick);			
			addEventListener(FocusEvent.FOCUS_IN,onFoucusIn);
			addEventListener(FocusEvent.FOCUS_OUT,onFoucusOut);
		}
		
		private function onClick( event:MouseEvent ) : void
		{
			if(event.target == this)
			{
				stage.focus = m_input;
			}
		} 
		
		private function onFoucusIn(event:FocusEvent) : void
		{
			if ( m_input.value == m_defaultValue ) 
			{
				m_input.value = "";
			}
		}
		
		private function onFoucusOut(event:FocusEvent) : void
		{
			if ( m_input.value == "")
			{
				m_input.value = m_defaultValue;
			}
			else
			{
				validate();
			}
		}

		internal function validateEmail() : Boolean
		{
    		var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
    		return pattern.test(m_input.value);
		}
		
		
		
		public function validate() : Boolean
		{
			if(m_isEmail && !validateEmail())
			{
				m_input.select();
				setError();
			}
			
			unsetError();
			return true;
		}

		public function setError() : void
		{
			
		}	
		
		public function unsetError() : void
		{
			
		}	
		
		public function reset() : void {
			m_input.value = m_defaultValue;
		}
		
		public function get id() : String
		{
			return m_id;
		}
		
		public function get data() : *
		{
			return {id:m_id,value:m_input.value};
		}
		
		public function set value(a_value:String) : void
		{
			m_value = a_value;
		}
		
		public function get value() : String 
		{
			return m_value;
		}
	}
}
