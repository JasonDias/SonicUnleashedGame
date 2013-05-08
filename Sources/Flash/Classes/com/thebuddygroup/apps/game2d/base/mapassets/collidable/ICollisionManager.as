package com.thebuddygroup.apps.game2d.base.mapassets.collidable 
{
	import flash.events.IEventDispatcher;	


	public interface ICollisionManager 
	{
		function addCollidable(myCollidable:ICollidable):void;
		function addCollidables(myCollidables:Array):void;
		function listenToCollisions(myCollisionDispatcher:IEventDispatcher):void
	}
}
