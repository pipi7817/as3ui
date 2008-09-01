package se.konstruktor.as3ui.controls.form
{
	import flash.events.IEventDispatcher;
	
	public interface IFormField extends IEventDispatcher
	{
		function validate()		: Boolean;
		function setError()		: void;
		function unsetError()	: void;

		function get id()		: String;
		function get data()		: *;

	}
}