package com.thebuddygroup.apps.game2d.base.mapassets.actions.factory {
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;	
	

	public interface IActionFactory {
		function getAction(myActionName:String):IPersistantAction;
		function initActionAndStoreInActionsMap(myActionName:String, myAction:IPersistantAction):void;
	}
}
