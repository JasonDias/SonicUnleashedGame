package com.thebuddygroup.apps.game2d.base.mapassets 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.CyclingActionList;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.PlayerCharacterActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationAssetManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAssetManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.PlayerCharacterInventory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	

	public class AbstractPlayerCharacter extends AbstractMapAsset 
	{
		protected var ourCollisionManager:ICollisionManager;
		protected var ourAnimationAssetManager:IAnimationAssetManager;
		protected var ourInventory:IInventory;
		
		
		public function AbstractPlayerCharacter(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0)
		{
			ourAnimationAssetManager	= new AnimationAssetManager();
			ourActionList 				= new CyclingActionList(this);
			ourCollisionManager			= new CollisionManager(this as ICollidable);
			ourInventory				= new PlayerCharacterInventory();
			
			ourActionFactory 			= new PlayerCharacterActionFactory(this as IPlayerCharacter);
			ourWorld					= myWorld;
			
			setViewport(myViewport);
			
			init(myX, myY, myRotation);
		}
		
		protected function init(myX:Number=0, myY:Number=0, myRotation:Number=0):void{	
			(this as IMapAsset).createBody(ourWorld, myX, myY, myRotation);			
		}
		
		public function getInventory():IInventory
		{
			return ourInventory;
		}
		
		public function destroyBody():void
		{
			if(ourBody)
				ourWorld.destroyBody(ourBody);
		}
		

		public function getCollisionManager():ICollisionManager
		{
			return ourCollisionManager;
		}
		
		public function getAnimationAssetManager():IAnimationAssetManager {
			return ourAnimationAssetManager;
		}
	}
}
