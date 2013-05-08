package prj.sonicunleashed.actions.sonic {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;	


	public class SonicBounceAwayAction extends AbstractPersistantAction implements IPersistantAction {
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset; 
			var myBody:b2Body			= myMapAsset.getBody();
			var myVelocity:b2Vec2		= myBody.GetLinearVelocity();
			
			if(myVelocity.x >= 0)
				myVelocity.x			= -8;
			else
				myVelocity.x			= 8;
			
			myVelocity.y				= -12;
			
			myBody.SetLinearVelocity(myVelocity);
			
			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.HIT);
			myAnimationManager.removeAnimationRequest(myMovementAnimationRequest);
			myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
		}
	}
}
