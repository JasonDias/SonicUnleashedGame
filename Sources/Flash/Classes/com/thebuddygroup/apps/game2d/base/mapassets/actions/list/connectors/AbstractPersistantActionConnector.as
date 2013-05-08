package com.thebuddygroup.apps.game2d.base.mapassets.actions.list.connectors {
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		


	public class AbstractPersistantActionConnector 
	{
		protected var ourAction:IPersistantAction;
		
		public function connectToPersistantAction(myPersistantAction:IPersistantAction):void
		{
			ourAction = myPersistantAction;
		}
		
	}
}
