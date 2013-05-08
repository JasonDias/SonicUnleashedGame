package prj.sonicunleashed.actions.sonic {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;	


	public class SonicSuperJumpAction extends AbstractPersistantAction implements IPersistantAction {
		private var ourJumpHeight:Number	= 95;
		
		public function start():void{
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset;
			var myBody:b2Body			= myMapAsset.getBody();
			var myVelocity:b2Vec2		= myBody.GetLinearVelocity();
			if(myVelocity.y > 0){
				myVelocity.y			= 0;//-myVelocity.y;//-ourJumpHeight;
				myBody.SetLinearVelocity(myVelocity);
			}
			myBody.WakeUp();			
			myBody.ApplyImpulse(new b2Vec2(0, -ourJumpHeight), myBody.GetPosition());
			
//			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
//			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.SUPER_JUMP);			
		}
		
		public function stop():void {
		}
		
		public function update():void {
		}
	}
}
