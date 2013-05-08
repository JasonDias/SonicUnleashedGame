package prj.sonicunleashed.assets.factories {
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	
	import com.carlcalderon.arthropod.Debug;	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	
	import flash.display.DisplayObject;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	
	import prj.sonicunleashed.assets.SelfDestructingDynamicRingAsset;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.AbstractMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;
	

	public class SelfDestructingDynamicRingAssetFactory extends AbstractMapAssetFactory implements IMapAssetFactory 
	{	
		public var selfDestructInSeconds:Number = 10;
		
		public function createMapAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myDisplayObject:DisplayObject, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):IMapAsset
		{
			var myAsset:IMapAsset = new SelfDestructingDynamicRingAsset(selfDestructInSeconds, myWorld, myViewport, myX, myY, myRotation);
			ourAssets.push(myAsset);
			return myAsset;
		}
		
	}
}
