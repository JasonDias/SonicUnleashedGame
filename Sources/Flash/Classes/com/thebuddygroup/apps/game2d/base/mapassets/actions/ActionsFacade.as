package com.thebuddygroup.apps.game2d.base.mapassets.actions {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.IActionList;	


	public class ActionsFacade {
		private static var ourInstance:ActionsFacade;
		
		public static function getInstance():ActionsFacade{
			if(ourInstance ==  null)
				ourInstance = new ActionsFacade();
			return ourInstance;
		}		
		
		public function addActionToMapAsset(myAction:IPersistantAction, myMapAsset:IMapAsset):void
		{
			myMapAsset.getActionList().addAction(myAction);
		}
		
		public function addAction(myActionName:String, myMapAsset:IMapAsset):IPersistantAction
		{
			var myAction:IPersistantAction = myMapAsset.getActionFactory().getAction(myActionName);
			if(myAction)
				addActionToMapAsset(myAction, myMapAsset);
			return myAction;
		}
		
		public function addActionAndStart(myActionName:String, myMapAsset:IMapAsset):IPersistantAction
		{
			var myAction:IPersistantAction	= addAction(myActionName, myMapAsset);
			if(myAction)
				myAction.start();
			return myAction;
		}		
	}
}

