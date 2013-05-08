package com.thebuddygroup.apps.game2d.base.mapassets.collidable 
{
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.trigger.ITriggerable;
	import com.thebuddygroup.apps.game2d.base.world.WorldContactEvent;
	
	import flash.events.IEventDispatcher;
	
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;		


	public class CollisionManager implements ICollisionManager, ITriggerable
	{
		private var ourCollidableItems:Array;
		private var ourCollidableIDMap:Array;
		private var ourCollidable:ICollidable;
		
		private var ourCollidedObjects:Object;
		
		function CollisionManager(myCollidable:ICollidable)
		{
			ourCollidable		= myCollidable;
			ourCollidableIDMap	= new Array();
			ourCollidableItems	= new Array();
			ourCollidedObjects	= new Object();
		} 

		public function addCollidable(myCollidable:ICollidable):void
		{
			ourCollidableItems.push(myCollidable);
				
			ourCollidableIDMap[myCollidable.getIdentifier().getID()] = false;
		}

		public function listenToCollisions(myCollisionDispatcher:IEventDispatcher):void
		{
			myCollisionDispatcher.addEventListener(WorldContactEvent.ADD, collisionAdd);
			myCollisionDispatcher.addEventListener(WorldContactEvent.PERSIST, collisionPersist);
			myCollisionDispatcher.addEventListener(WorldContactEvent.REMOVE, collisionRemove);
			myCollisionDispatcher.addEventListener(WorldContactEvent.RESULT, collisionResult);
		}
		
		public function applyCollisions():void{
			for each(var myCollidable:ICollidable in ourCollidedObjects) {
				ourCollidable.collisionOccurred(myCollidable);
				myCollidable.collisionOccurred(ourCollidable);
			}
			ourCollidedObjects = new Object();
		}
		
		private function collisionAdd(myEvent:WorldContactEvent):void
		{
			var myCollidable1:ICollidable	= myEvent.getCollisionBody1().m_userData as ICollidable;
			var myCollidable2:ICollidable	= myEvent.getCollisionBody2().m_userData as ICollidable;
			addCollided(myCollidable1, myCollidable2);
		}
		
		private function iAmInterestedInThisCollision(myCollidable1:ICollidable, myCollidable2:ICollidable):Boolean{
			if(myCollidable1 && myCollidable2){
				if(ourCollidable == myCollidable1 || ourCollidable == myCollidable2){
					for each(var myCollidable:ICollidable in ourCollidableItems){
						if(myCollidable == myCollidable1 || myCollidable == myCollidable2) {
							return true;
						}		
					}
				}
			}
			return false;
		}

		private function collisionPersist(myEvent:WorldContactEvent):void
		{
		}
		
		private function collisionRemove(myEvent:WorldContactEvent):void
		{
			var myCollidable1:ICollidable	= myEvent.getCollisionBody1().m_userData as ICollidable;
			var myCollidable2:ICollidable	= myEvent.getCollisionBody2().m_userData as ICollidable;
			
			removeCollided(myCollidable1, myCollidable2);
		}
		
		private function collisionResult(myEvent:WorldContactEvent):void
		{
			
		}
		
		private function addCollided(myCollidable1:ICollidable, myCollidable2:ICollidable):void{
			if(iAmInterestedInThisCollision(myCollidable1, myCollidable2)){
				var myCollided:ICollidable		= (ourCollidable == myCollidable1)?myCollidable2:myCollidable1;
				var myID:uint					= myCollided.getIdentifier().getID();
				ourCollidedObjects[myID]		= myCollided;
			}
		}
		
		private function removeCollided(myCollidable1:ICollidable, myCollidable2:ICollidable):void{
			if(iAmInterestedInThisCollision(myCollidable1, myCollidable2)){
				var myCollided:ICollidable		= (ourCollidable == myCollidable1)?myCollidable2:myCollidable1;
				var myID:uint					= myCollided.getIdentifier().getID();
				delete ourCollidedObjects[myID];
			}
		}	
		
		public function addCollidables(myCollidables:Array):void
		{
			for each(var myCollidable:ICollidable in myCollidables) {
				addCollidable(myCollidable);
			}
		}
		
		public function trigger(myTrigger:ITrigger):void {
			applyCollisions();
		}
	}
}
