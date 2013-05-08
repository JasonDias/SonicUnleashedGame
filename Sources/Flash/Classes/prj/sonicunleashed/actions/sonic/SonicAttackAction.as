package prj.sonicunleashed.actions.sonic 
{
	import flash.utils.setTimeout;	
	
	import prj.sonicunleashed.Sonic;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;	

	public class SonicAttackAction extends AbstractPersistantAction implements IPersistantAction
	{
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myMapAsset:IMapAsset							= getTarget() as IMapAsset; 
			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.ATTACK);
			myAnimationManager.removeAnimationRequest(myMovementAnimationRequest);
			myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
			
			//TODO: Ummm,,,, I need to get these number dynamically
			var myPunchFrame:uint	= 3;
			var myPunchFPS:uint		= 20;
			setTimeout((myMapAsset as Sonic).attack, 1000*myPunchFrame/myPunchFPS);
		}
	}
}
