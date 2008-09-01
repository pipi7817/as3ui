	package se.konstruktor.as3ui.controls.input {
	import flash.events.FocusEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import se.konstruktor.as3ui.controls.button.BaseButton;
	
	
	public class BaseInput extends BaseButton
	{
		protected var m_inputField:TextField;

		public function BaseInput(a_input:TextField)
		{
			m_inputField = a_input;
			m_inputField.type = TextFieldType.INPUT;
			m_inputField.addEventListener(FocusEvent.FOCUS_IN,onFoucusIn);
			m_inputField.addEventListener(FocusEvent.FOCUS_OUT,onFoucusOut);
			addChild(m_inputField);			
		} 
		
		public function select():void
		{
			if(m_inputField.text != "")
			{
				stage.focus = m_inputField;
				m_inputField.setSelection(0,m_inputField.text.length);
			}
		}
		
		public function set value( a_value:String ) : void
		{
			m_inputField.text = a_value;
		}

		public function get value() : String
		{
			return m_inputField.text;
		}
		
		public function get textfield() : TextField
		{
			return m_inputField;	
		}
		
		protected function onFoucusIn(event:FocusEvent):void
		{
//			filters = [new GlowFilter(0x86c6e1) ];
		}

		protected function onFoucusOut(event:FocusEvent):void
		{
//			filters = [];
		}

	}
}
