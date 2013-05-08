package com.thebuddygroup.apps.game2d.base.mapassets.actions 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;	
	
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.Sonic;
	
	import com.carlcalderon.arthropod.Debug;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;		

	public class PlayerCharacterMovementWatchAction extends AbstractPersistantAction implements IPersistantAction 
	{
		private var ourSuperRunMinVelocity:Number = 16;
		
		private var ourLastAnimationRequest:IAnimationRequest;
		
		public function stop():void {
			dispatchRemoveFromListEvent();
		}
		
		public function update():void {
			var myMapAsset:IMapAsset					= getTarget() as IMapAsset;
			var myBody:b2Body							= myMapAsset.getBody();
			var myAnimationManager:IAnimationManager	= myMapAsset.getAnimationManager();
			var myMovementAnimationRequest:IAnimationRequest;			
			
			if(isIdle(myBody)) {
				myMovementAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.IDLE);
			}else{
				if(isJumping(myBody)) {
					myMovementAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.JUMP);				
				}else{
					//TODO: seriously, move these to another class
					//Seriously!!!!!
					var myVel:b2Vec2						= myBody.GetLinearVelocity();
					var myAnimationAsset:IAnimationAsset	= (myMapAsset as IPlayerCharacter).getAnimationAssetManager().getAsset(Sonic.ANIMATION_ASSET_RUN);
					var myFPSPct:Number						= Math.abs(myVel.x) / ourSuperRunMinVelocity;
					var myFPS:uint							= 20 + Math.ceil(myFPSPct * 100);
					
					if(Math.abs(myAnimationAsset.getFPS() - myFPS) > 3)
						myAnimationAsset.setFPS(myFPS);
				
					 
					if(Math.abs(myVel.x) > ourSuperRunMinVelocity){
						myMovementAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.SUPER_RUN);					
					}else{
						myMovementAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.RUN);
					}					
				}
			}
			
			if(myMovementAnimationRequest != ourLastAnimationRequest){
				myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
				if(ourLastAnimationRequest)
					myAnimationManager.removeAnimationRequest(ourLastAnimationRequest);
				ourLastAnimationRequest = myMovementAnimationRequest;
			}
		}
		
		public function start():void {
			dispatchAddToListEvent();
		}
		
		protected function isJumping(myBody:b2Body):Boolean{
			var myManifold:b2Manifold;
			for (var myCurrentContactEdge:b2ContactEdge = myBody.m_contactList; myCurrentContactEdge != null ; myCurrentContactEdge = myCurrentContactEdge.next){
				myManifold = myCurrentContactEdge.contact.GetManifolds()[0];
				if (myCurrentContactEdge.contact.GetShape1().GetBody() == myBody){
					if (myManifold.normal.y > 0) return false;
				}else{
					if (myManifold.normal.y < 0) return false;
				}
			}
			return true;
		}
		
		protected function isIdle(myBody:b2Body):Boolean{
			var myVelocity:b2Vec2	= myBody.GetLinearVelocity();
			return (Math.abs(myVelocity.x) < 0.0001 && Math.abs(myVelocity.y) < 0.0001);
		}
		
		protected function getRunAnimation(myBody:b2Body):String{
			if(Math.abs(myBody.GetLinearVelocity().x) > ourSuperRunMinVelocity){
				return PlayerCharacterAnimation.SUPER_RUN;
			}else{
				return PlayerCharacterAnimation.RUN;
			}
		}
	}
}
