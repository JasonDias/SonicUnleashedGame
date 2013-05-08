package prj.sonicunleashed.animations 
{
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;	
	
	import Box2D.Dynamics.b2Body;	
	import Box2D.Common.Math.b2Vec2;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationAssetEvent;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAssetManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimationManager;
	
	import prj.sonicunleashed.Sonic;	


	public class SonicAnimationManager extends PlayerCharacterAnimationManager implements IAnimationManager {
		
		public function SonicAnimationManager(myMapAsset:IMapAsset)
		{
			super(myMapAsset);
		}
		
		private function getPlayerAnimationAssetManager():IAnimationAssetManager{
			var myPlayer:IPlayerCharacter					= ourMapAsset as IPlayerCharacter;
			var myPlayerAnimAssetMan:IAnimationAssetManager	= myPlayer.getAnimationAssetManager();
			return myPlayerAnimAssetMan;
		}
		
		override protected function doMovementAnimation():void{
			var myAnimationName:String						= ourCurrentMovementAnimationRequest.getAnimationName();
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset;
			myPlayerAnimAssetMan.stopAndHideAll();
			
			switch(myAnimationName){
				case PlayerCharacterAnimation.IDLE:
					myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_IDLE).playAndShow();
					break;
				case PlayerCharacterAnimation.SUPER_RUN:
					myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_SUPER_RUN).playAndShow();
					myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_BOOST_EFFECT).playAndShow();
					break;
				case PlayerCharacterAnimation.RUN:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_RUN);					
					myAnimationAsset.playAndShow();
					break;
				case PlayerCharacterAnimation.JUMP:
				case PlayerCharacterAnimation.SUPER_JUMP:
					myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_JUMP).playAndShow();
					break;
				case PlayerCharacterAnimation.SUPER_RUN:
					myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_SUPER_RUN).playAndShow();
					break;
				case PlayerCharacterAnimation.RING:
					//nothing special
					break;
				case PlayerCharacterAnimation.HIT:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_HIT);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onHitAnimationComplete);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onHitAnimationComplete); 
					myAnimationAsset.playAndShow();
					break;
				case PlayerCharacterAnimation.DANCE:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_DANCE);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onDanceAnimationComplete);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onDanceAnimationComplete); 
					myAnimationAsset.playAndShow();
					break;
				case PlayerCharacterAnimation.ATTACK:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_ATTACK);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onAttackAnimationComplete);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onAttackAnimationComplete); 
					myAnimationAsset.playAndShow();
					break;
				case PlayerCharacterAnimation.CLIMB:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_CLIMB);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onClimbAnimationComplete);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onClimbAnimationComplete); 
					myAnimationAsset.playAndShow();
					break;
			}
		}
		
		override protected function doFacingAnimation():void{
			var myAnimationName:String	= ourCurrentFacingAnimationRequest.getAnimationName();
			setFacingDirection(myAnimationName);
		}
		
		protected function setFacingDirection(myDirection:String):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			
			switch(myDirection){
				case PlayerCharacterAnimation.FACE_LEFT:
					myPlayerAnimAssetMan.faceAllLeft();
					break;
				case PlayerCharacterAnimation.FACE_RIGHT:
					myPlayerAnimAssetMan.faceAllRight();
					break;
			}
		}
		
		protected function onHitAnimationComplete(myEvent:AnimationAssetEvent):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_HIT);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onHitAnimationComplete);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onHitAnimationComplete);
			
			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.HIT);
			removeAnimationRequest(myAnimationRequest);
		}
		
		protected function onDanceAnimationComplete(myEvent:AnimationAssetEvent):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_DANCE);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onDanceAnimationComplete);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onDanceAnimationComplete);
			
			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.DANCE);
			removeAnimationRequest(myAnimationRequest);
		}
		
		protected function onAttackAnimationComplete(myEvent:AnimationAssetEvent):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_ATTACK);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onAttackAnimationComplete);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onAttackAnimationComplete);
			
			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.ATTACK);
			removeAnimationRequest(myAnimationRequest);
		}
		
		protected function onClimbAnimationComplete(myEvent:AnimationAssetEvent):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(Sonic.ANIMATION_ASSET_CLIMB);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onClimbAnimationComplete);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onClimbAnimationComplete);
			
			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.CLIMB);
			removeAnimationRequest(myAnimationRequest);
			
			var myWorldUnits:IWorldUnits					= ourMapAsset.getWorld().getWorldUnits();
			var myMoveUpAmount:Number						= myWorldUnits.getMetersFromPixels(200);
			var myPos:b2Vec2;
			var myBodies:Array								= (ourMapAsset as Sonic).getBodies();
			for each(var myBody:b2Body in myBodies){
				myPos		= myBody.GetPosition();
				myPos.y		-= myMoveUpAmount;
				myBody.SetXForm(myPos, 0);
			}
		}
	}
}