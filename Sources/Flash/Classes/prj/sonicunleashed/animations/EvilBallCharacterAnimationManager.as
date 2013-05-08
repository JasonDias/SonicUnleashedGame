package prj.sonicunleashed.animations 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IHaveLifeEnergy;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationAssetEvent;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAssetManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimationManager;
	
	import prj.sonicunleashed.assets.EvilBallCharacter;		


	public class EvilBallCharacterAnimationManager extends PlayerCharacterAnimationManager implements IAnimationManager 
	{
		public function EvilBallCharacterAnimationManager(myMapAsset:IMapAsset)
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
					myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_IDLE).playAndShow();
					break;
				case PlayerCharacterAnimation.SUPER_RUN:
					myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_SUPER_RUN).playAndShow();
					myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_BOOST_EFFECT).playAndShow();
					break;
				case PlayerCharacterAnimation.RUN:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_RUN);					
					myAnimationAsset.playAndShow();
					break;
				case PlayerCharacterAnimation.JUMP:
				case PlayerCharacterAnimation.SUPER_JUMP:
					myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_JUMP).playAndShow();
					break;
				case PlayerCharacterAnimation.SUPER_RUN:
					myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_SUPER_RUN).playAndShow();
					break;
				case PlayerCharacterAnimation.RING:
					//nothing special
					break;
				case PlayerCharacterAnimation.HIT:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_HIT);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onHitAnimationComplete);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onHitAnimationComplete); 
					myAnimationAsset.playAndShow();
					startHitSequence();
					break;
				case PlayerCharacterAnimation.DANCE:
					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_DANCE);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onDanceAnimationComplete);
					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onDanceAnimationComplete); 
					myAnimationAsset.playAndShow();
					break;
//				case PlayerCharacterAnimation.ATTACK:
//					myAnimationAsset	= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_ATTACK);
//					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onAttackAnimationComplete);
//					myAnimationAsset.getDispatcher().addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onAttackAnimationComplete); 
//					myAnimationAsset.playAndShow();
//					break;
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
		
		protected function startHitSequence():void{
			(ourMapAsset as EvilBallCharacter).youGotHit();			
		}
		
		protected function onHitAnimationComplete(myEvent:AnimationAssetEvent):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_HIT);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onHitAnimationComplete);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onHitAnimationComplete);
			
			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.HIT);
			removeAnimationRequest(myAnimationRequest);
			
			(ourMapAsset as EvilBallCharacter).youAreDoneFeelingThePain();
		}

		protected function onDanceAnimationComplete(myEvent:AnimationAssetEvent):void{
			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_DANCE);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onDanceAnimationComplete);
			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onDanceAnimationComplete);
			
			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.DANCE);
			removeAnimationRequest(myAnimationRequest);
		}
		
//		protected function onAttackAnimationComplete(myEvent:AnimationAssetEvent):void{
//			var myPlayerAnimAssetMan:IAnimationAssetManager	= getPlayerAnimationAssetManager();
//			var myAnimationAsset:IAnimationAsset			= myPlayerAnimAssetMan.getAsset(EvilBallCharacter.ANIMATION_ASSET_ATTACK);
//			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT, onAttackAnimationComplete);
//			myAnimationAsset.getDispatcher().removeEventListener(AnimationAssetEvent.ANIMATION_COMPLETE, onAttackAnimationComplete);
//			
//			var myAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.ATTACK);
//			removeAnimationRequest(myAnimationRequest);
//		}
	}
}
