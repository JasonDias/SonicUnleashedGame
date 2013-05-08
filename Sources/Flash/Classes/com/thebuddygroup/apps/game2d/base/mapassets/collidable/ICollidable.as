package com.thebuddygroup.apps.game2d.base.mapassets.collidable 
{
	import com.thebuddygroup.apps.game2d.base.IIdentifiable;		


	public interface ICollidable extends IIdentifiable
	{
		function collisionOccurred(myCollidable:ICollidable):void;
		function getCollisionManager():ICollisionManager;
	}
}
