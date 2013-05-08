package com.thebuddygroup.apps.game2d.base.world.stats 
{
	import com.thebuddygroup.apps.game2d.base.trigger.ITriggerable;
	
	import flash.events.IEventDispatcher;		


	public interface IWorldStats extends IEventDispatcher, ITriggerable
	{
		function setBodyCount(myCount:uint):void;
		function getBodyCount():uint;
		
		function setProxyCount(myCount:uint):void;
		function getProxyCount():uint;
		
		function setJointCount(myCount:uint):void;
		function getJointCount():uint;
	}
}
