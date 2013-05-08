package com.thebuddygroup.apps.game2d.base.mapassets.actions {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.b2Body;	

	public class PlayerCharacterJumpAction extends AbstractPersistantAction implements IPersistantAction
	{
		protected var ourJumpHeight:Number	= 20;
		
		public function update():void {
			
		}
		
		public function start():void {			
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset;
			var myBody:b2Body			= myMapAsset.getBody();
			
			if(isMovementAllowed(myBody)){
				myBody.WakeUp();
				myBody.SetLinearVelocity(new b2Vec2(myBody.GetLinearVelocity().x, -Math.abs(ourJumpHeight)));
//				var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
//				var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.JUMP);
//				myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
			}
		}
		
		public function stop():void {
//			var myMapAsset:IMapAsset							= getTarget() as IMapAsset;
//			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
//			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.JUMP);
//			myAnimationManager.removeAnimationRequest(myMovementAnimationRequest);			
		}
		
		protected function isMovementAllowed(myBody:b2Body):Boolean{
			var myManifold:b2Manifold;
			for (var myCurrentContactEdge:b2ContactEdge = myBody.m_contactList; myCurrentContactEdge != null ; myCurrentContactEdge = myCurrentContactEdge.next){
				myManifold = myCurrentContactEdge.contact.GetManifolds()[0];
				if (myCurrentContactEdge.contact.GetShape1().GetBody() == myBody){
					if (myManifold.normal.y > 0) return true;
				}else{
					if (myManifold.normal.y < 0) return true;
				}
			}
			return false;
		}
	}
}
