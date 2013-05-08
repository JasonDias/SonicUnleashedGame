package prj.sonicunleashed.actions.sonic 
{
	import prj.sonicunleashed.Sonic;	
	
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterJumpAction;	

	public class SonicJumpAction extends PlayerCharacterJumpAction implements IPersistantAction 
	{
		override public function start():void {			
			dispatchAddToListEvent();
			
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset;
			var myBody:b2Body			= myMapAsset.getBody();
			if(isMovementAllowed(myBody)){
				super.start();
				myMapAsset.getSoundManager().playSound(Sonic.LIB_ASSET_JUMP_SOUND_CLASS_NAME);
			}
			
			dispatchRemoveFromListEvent();
		}	
	}
}
