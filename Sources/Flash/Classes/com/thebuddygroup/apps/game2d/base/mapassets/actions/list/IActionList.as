package com.thebuddygroup.apps.game2d.base.mapassets.actions.list 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.ITriggerable;		


	public interface IActionList extends ITriggerable  
	{
		function addAction(myAction:IPersistantAction):void;
		function removeAction(myAction:IPersistantAction):void;
		function getCurrentActions():Array;
		function setListCyclingTrigger(myTrigger:ITrigger):void;
	}
}
