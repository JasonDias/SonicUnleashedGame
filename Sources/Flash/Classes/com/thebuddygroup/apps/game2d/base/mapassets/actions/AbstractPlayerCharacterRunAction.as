package com.thebuddygroup.apps.game2d.base.mapassets.actions 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;	

	public class AbstractPlayerCharacterRunAction extends AbstractPersistantAction
	{
		protected var ourAccelBy:Number		= 1.5;
		protected var ourMaxVelocity:Number	= 15;
		
		
		public function start():void
		{
			dispatchAddToListEvent();			
			update();
		}
		
		public function stop():void
		{
			dispatchRemoveFromListEvent();
		}
		
		public function update():void {
			
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset;
			var myBody:b2Body			= myMapAsset.getBody();
			var myVelocity:b2Vec2		= myBody.GetLinearVelocity();
			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
			var myFacingDirection:String						= (ourAccelBy >=0)?PlayerCharacterAnimation.FACE_RIGHT:PlayerCharacterAnimation.FACE_LEFT;
			var myFacingAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(myFacingDirection);
			myAnimationManager.addAnimationRequest(myFacingAnimationRequest);
			
			if((myVelocity.x > 0 && ourAccelBy < 0) || (myVelocity.x < 0 && ourAccelBy > 0)){
				myVelocity.x	= 0;
				myBody.SetLinearVelocity(myVelocity);
			}
			
			if(Math.abs(myVelocity.x) < Math.abs(ourMaxVelocity)){	
				myBody.ApplyImpulse(new b2Vec2(ourAccelBy, 0), myBody.GetPosition());
			}
		}		
	}
}
