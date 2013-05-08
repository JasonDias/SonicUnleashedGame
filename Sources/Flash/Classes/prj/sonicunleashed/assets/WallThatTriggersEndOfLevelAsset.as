package prj.sonicunleashed.assets 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	

	public class WallThatTriggersEndOfLevelAsset extends WallAsset implements IMapAsset, ICollidable
	{
		private var ourCollisionManager:ICollisionManager;
		
		public function WallThatTriggersEndOfLevelAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0) {
			super(myWorld, myViewport, myX, myY, myRotation);
			ourCollisionManager = new CollisionManager(this);			
		}
		
		public function collisionOccurred(myCollidable:ICollidable):void {
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			//throw new Error('TODO: Implement End of Level logic. Probably trigger a video, then show your score, then submit score etc...');
			Application.getMain().getGame().endOfLevelReached();
		}
		
		public function getCollisionManager():ICollisionManager {
			return ourCollisionManager;
		}
	}
}
