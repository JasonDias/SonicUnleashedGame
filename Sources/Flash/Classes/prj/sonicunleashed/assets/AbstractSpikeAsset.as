package prj.sonicunleashed.assets 
{
	import prj.sonicunleashed.sound.SpikeSoundManager;	
	
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.actions.SpikeActions;
	import prj.sonicunleashed.actions.factories.SpikeAssetActionFactory;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	


	public class AbstractSpikeAsset extends AbstractMapAsset
	{
		public static const LIB_ASSET_DOINK_SOUND_CLASS_NAME:String	= 'LibAssetDoinkSound';
		
		protected var ourCollisionManager:ICollisionManager;
		protected var ourHitAction:IPersistantAction;		
		protected var ourSpikeBody:b2Body;
		
		public function AbstractSpikeAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0)
		{
			super();
			ourWorld				= myWorld;
			ourActionFactory		= new SpikeAssetActionFactory(this as IMapAsset);
			ourSoundManager			= new SpikeSoundManager(this as IMapAsset);
			ourHitAction			= ActionsFacade.getInstance().addAction(SpikeActions.SPIKE_HIT_ACTION, this as IMapAsset);
			ourCollisionManager 	= new CollisionManager(this as ICollidable);
			
			setViewport(myViewport);
			init(myWorld, myViewport, myX, myY, myRotation);
		}
		
		protected function init(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			(this as IMapAsset).createBody(myWorld, myX, myY, myRotation);
		}
		
		public function collisionOccurred(myCollidable:ICollidable):void {
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			ActionsFacade.getInstance().addActionAndStart(SpikeActions.SPIKE_HIT_ACTION, myCollidedAsset);
			
			ourHitAction.start();			
		}

		public function getCollisionManager():ICollisionManager {
			return ourCollisionManager;
		}		
		
		public function destroyBody():void
		{
			ourWorld.destroyBody(ourSpikeBody);
			ourWorld.destroyBody(ourBody);
		}		
	}
}
