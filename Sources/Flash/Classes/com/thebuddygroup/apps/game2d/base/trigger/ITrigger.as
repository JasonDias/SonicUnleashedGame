package com.thebuddygroup.apps.game2d.base.trigger 
{


	public interface ITrigger extends ITriggerable
	{
		function connect(myTriggerable:ITriggerable):void;
		function disconnect(myTriggerable:ITriggerable):void;
	}
}
