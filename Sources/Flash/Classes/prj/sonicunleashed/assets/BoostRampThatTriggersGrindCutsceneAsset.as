package prj.sonicunleashed.assets 
{
	import prj.sonicunleashed.actions.sonic.SonicActions;
	import prj.sonicunleashed.assets.BoostRampAsset;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	

	public class BoostRampThatTriggersGrindCutsceneAsset extends BoostRampAsset implements IMapAsset, ICollidable
	{
		public function BoostRampThatTriggersGrindCutsceneAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0) {
			super(myWorld, myViewport, myX, myY, myRotation);
		}
				
		override public function collisionOccurred(myCollidable:ICollidable):void {
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			if(!ourDisplay.parent)
				return;
			
			ActionsFacade.getInstance().addActionAndStart(SonicActions.BOOST_RAMP_PLAY_GRIND_RAIL_CUTSCENE_ACTION, myCollidedAsset);
		}
	}
}
