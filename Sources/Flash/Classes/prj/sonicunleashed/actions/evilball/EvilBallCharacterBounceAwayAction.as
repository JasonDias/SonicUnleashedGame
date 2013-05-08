package prj.sonicunleashed.actions.evilball 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;	


	public class EvilBallCharacterBounceAwayAction extends AbstractPersistantAction implements IPersistantAction {
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset; 
			var myBody:b2Body			= myMapAsset.getBody();
			var myVelocity:b2Vec2		= myBody.GetLinearVelocity();
			
			myVelocity.x				= 0;
			myVelocity.y				= 0;
			
			if(myVelocity.x > 0)
				myVelocity.x			= -3;
			else if(myVelocity.x < 0)
				myVelocity.x			= 3;
			
			
			myBody.SetLinearVelocity(myVelocity);
			
			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.HIT);
			myAnimationManager.removeAnimationRequest(myMovementAnimationRequest);
			myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
		}
	}
}
