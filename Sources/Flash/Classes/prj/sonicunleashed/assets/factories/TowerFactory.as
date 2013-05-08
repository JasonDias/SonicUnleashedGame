package prj.sonicunleashed.assets.factories 
{
	import prj.sonicunleashed.assets.TowerAsset;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.AbstractMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import flash.display.DisplayObject;	


	public class TowerFactory extends AbstractMapAssetFactory implements IMapAssetFactory 
	{
		public function createMapAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myDisplayObject:DisplayObject, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):IMapAsset {
			var myAsset:IMapAsset		= new TowerAsset(myWorld, myViewport, myX, myY, myRotation);
			ourAssets.push(myAsset);
			return myAsset;
		}
	}
}
