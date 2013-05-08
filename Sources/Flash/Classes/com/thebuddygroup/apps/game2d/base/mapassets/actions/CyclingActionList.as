package com.thebuddygroup.apps.game2d.base.mapassets.actions 
{
	import com.adobe.utils.ArrayUtil;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.IActionList;
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;		


	public class CyclingActionList implements IActionList 
	{
		private var ourActions:Array;
		private var ourTarget:Object;

		function CyclingActionList(myTarget:Object)
		{
			ourTarget	= myTarget;
			ourActions	= new Array();
		}
		
		public function addAction(myAction:IPersistantAction):void
		{
			if(!myAction)
				throw new Error('Tried to add a null action: '+myAction);
			//myAction.addList(this);
			myAction.setTarget(ourTarget);
			myAction.addEventListener(ActionEvent.REMOVE_FROM_LIST, actionRequestedToBeRemovedFromList);
			myAction.addEventListener(ActionEvent.ADD_TO_LIST, actionRequestedToBeAddedToList);
		}
		
		private function actionRequestedToBeAddedToList(myEvent:ActionEvent):void
		{
			addActionToUpdateList(myEvent.getAction() as IPersistantAction);	
		}
		
		private function addActionToUpdateList(myAction:IPersistantAction):void 
		{
			ourActions.push(myAction);
		}

		private function actionRequestedToBeRemovedFromList(myEvent:ActionEvent):void
		{
			removeActionFromUpdateList(myEvent.getAction() as IPersistantAction); 	
		}
		
		private function removeActionFromUpdateList(myAction:IPersistantAction):void{
			ArrayUtil.removeValueFromArray(ourActions, myAction);
		}

		public function removeAction(myAction:IPersistantAction):void
		{
			removeActionFromUpdateList(myAction);
			myAction.removeEventListener(ActionEvent.REMOVE_FROM_LIST, actionRequestedToBeRemovedFromList);
			myAction.removeEventListener(ActionEvent.ADD_TO_LIST, actionRequestedToBeAddedToList);
		}

		public function getCurrentActions():Array
		{
			return ourActions;
		}
		
		public function setListCyclingTrigger(myTrigger:ITrigger):void
		{
			myTrigger.connect(this);
		}
		
		public function trigger(myTrigger:ITrigger):void
		{
			updateAllActions();
		}
		
		private function updateAllActions():void
		{
			for each(var myAction:IPersistantAction in ourActions) {				
				myAction.update();
			}
		}
	}
}
