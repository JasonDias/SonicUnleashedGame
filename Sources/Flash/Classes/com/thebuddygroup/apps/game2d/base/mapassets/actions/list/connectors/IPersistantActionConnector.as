package com.thebuddygroup.apps.game2d.base.mapassets.actions.list.connectors {
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		


	public interface IPersistantActionConnector 
	{
		function connectToPersistantAction(myPersistantAction:IPersistantAction):void;
	}
}
