/*
* WARNING: Focus manager is under development dont use. 
*/


package as3ui.managers
{
	import flash.display.Stage;
	
	import as3ui.utils.stage.TopLevel;
	
	public class FocusManager
	{
		
		internal var m_focusList	:	Array;
		internal var m_groupList	:	Array;

		private var m_active		:	FocusObjectWraper;
		private var m_stage			:	Stage;
		
		public function FocusManager()
		{
			m_focusList = new Array();
		}
		
		public function add(a_obj:IFocusObject, a_id:String = "", a_groupId:String = ""):void
		{
//			if(m_stage == null) m_stage = TopLevel.getInstance().stage;
//			var pattern:RegExp = /^[0-9_]/;
//			if(pattern.test(a_id)) a_id = "_" + a_id;
//			if(pattern.test(a_groupId)) a_groupId = "_" + a_groupId;
			
			m_focusList.push(new FocusObjectWraper(a_obj,a_id,a_groupId) );

			sortList();
		}
		
		public function remove(a_obj:IFocusObject):Boolean
		{
			return false;
		}
		
		internal function sortList():void
		{
			m_focusList = m_focusList.sortOn(["id"],[Array.CASEINSENSITIVE]);
			m_groupList = m_focusList.sortOn(["group"],[Array.CASEINSENSITIVE]);
		}

	}
}

import as3ui.managers.IFocusObject;
internal class FocusObjectWraper
{
	public var instance:IFocusObject;
	public var id:String;
	public var group:String;

	public function FocusObjectWraper(a_obj:IFocusObject,a_id:String,a_group:String)
	{
		instance	= a_obj;
		id			= a_id;
		group		= a_group;
	}
	
	public function toString():String
	{
		var ret:String = instance+","+id+","+group;
		return ret;
	}
	
}