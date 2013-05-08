package com.thebuddygroup.apps.game2d.base.mapassets.actions.factory {
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		


	public class AbstractActionFactory
	{		
		protected var ourTarget:Object;
		protected var ourActionsMap:Object;
		
		function AbstractActionFactory(myTarget:Object) {
			ourTarget		= myTarget;
			ourActionsMap	= new Object();
		}

		public function getAction(myActionName:String):IPersistantAction 
		{
			return ourActionsMap[myActionName];
		}
		
		public function initActionAndStoreInActionsMap(myActionName:String, myAction:IPersistantAction):void{
			myAction.setTarget(ourTarget);
			ourActionsMap[myActionName]	= myAction;
		}
	}
}
