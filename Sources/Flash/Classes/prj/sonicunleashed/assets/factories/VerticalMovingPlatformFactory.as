package prj.sonicunleashed.assets.factories 
{
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.MovingPlatform;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.AbstractMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.RenderPersistantTrigger;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import flash.display.DisplayObject;	

	public class VerticalMovingPlatformFactory extends AbstractMapAssetFactory implements IMapAssetFactory {
		public function createMapAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myDisplayObject:DisplayObject, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):IMapAsset {
			var myAsset:IMapAsset					= new MovingPlatform(myWorld, myViewport, myX, myY, myRotation);
			//TODO: fix this shit
//			var myBody:b2Body						= myAsset.getBody();
//			var myRootBody:b2Body					= myWorld.getBodyLinkedList();
//			var myRenderTrigger:ITrigger			= new RenderPersistantTrigger(myWorld.getRenderer());
//			var myPlatformMovement:IBodyMovement	= new OscillatingBodyMovement(myRootBody, myBody, OscillatingBodyMovement.UP_DOWN, 0.1, .1);
//			myRenderTrigger.connect(myPlatformMovement);
//			
//			ourAssets.push(myAsset);
			return myAsset;
		}
	}
}
