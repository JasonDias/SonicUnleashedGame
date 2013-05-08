package com.thebuddygroup.apps.game2d.base.world.stats 
{
	import Box2D.Dynamics.b2World;
	
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;
	import com.thebuddygroup.apps.game2d.base.world.stats.IWorldStats;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	


	public class WorldStats extends EventDispatcher implements IWorldStats 
	{
		private var ourWorld:b2World;
		private var ourBodyCount:uint	= 0;
		private var ourProxyCount:uint	= 0;
		private var ourJointCount:uint	= 0;
		
		function WorldStats(myWorld:b2World){
			ourWorld	= myWorld;
		}
		
		public function trigger(myTrigger:ITrigger):void{
			ourBodyCount	= ourWorld.GetBodyCount();
			ourJointCount	= ourWorld.GetJointCount();
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function setBodyCount(myCount:uint):void
		{
			ourBodyCount	= myCount;
		}
		
		public function getBodyCount():uint
		{
			return ourBodyCount;
		}
		
		public function setProxyCount(myCount:uint):void
		{
			ourProxyCount	= myCount;
		}
		
		public function getProxyCount():uint
		{
			return ourProxyCount;
		}
		
		public function setJointCount(myCount:uint):void
		{
			ourJointCount	= myCount;
		}
		
		public function getJointCount():uint
		{
			return ourJointCount;
		}
	}
}
