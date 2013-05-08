package com.thebuddygroup.apps.tilescrollingengine 
{
	import com.carlcalderon.arthropod.Debug;	
	
	import flash.events.Event;	
	import flash.events.IEventDispatcher;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationAssetEvent;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	


	public class DirectionalSpriteSheetAnimator extends AbstractMapAsset implements IMapAsset, IAnimationAsset
	{
		protected var ourRightFacingAnimation:IAnimationAsset;
		protected var ourLeftFacingAnimation:IAnimationAsset;
		protected var ourCurrentAnimation:IAnimationAsset;
		
		public function DirectionalSpriteSheetAnimator(myRightFacingAnimationAsset:IAnimationAsset, myLeftFacingAnimationAsset:IAnimationAsset) {
			ourCurrentAnimation		= ourRightFacingAnimation = myRightFacingAnimationAsset;
			ourLeftFacingAnimation	= myLeftFacingAnimationAsset;
			
			addEventRedispatcher(ourRightFacingAnimation.getDispatcher());
			addEventRedispatcher(ourLeftFacingAnimation.getDispatcher());
			
			ourDisplay.addChild((ourRightFacingAnimation as IMapAsset).getDisplay());
			ourDisplay.addChild((ourLeftFacingAnimation as IMapAsset).getDisplay());
			
			
			faceRight();
		}
		
		protected function addEventRedispatcher(myEventDispatcher:IEventDispatcher):void {
			myEventDispatcher.addEventListener(AnimationAssetEvent.ANIMATION_START,		redistAnimationEvent);
			myEventDispatcher.addEventListener(AnimationAssetEvent.ANIMATION_STEP,		redistAnimationEvent);
			myEventDispatcher.addEventListener(AnimationAssetEvent.ANIMATION_INTERRUPT,	redistAnimationEvent);
			myEventDispatcher.addEventListener(AnimationAssetEvent.ANIMATION_COMPLETE,	redistAnimationEvent);
		}
		
		protected function redistAnimationEvent(myEvent:AnimationAssetEvent):void{
			ourDispatcher.dispatchEvent(new AnimationAssetEvent(myEvent.type));
		}

		public function play():void {
			ourCurrentAnimation.play();
		}
		
		public function stop():void {
			ourCurrentAnimation.stop();
		}
		
		public function show():void {
			ourCurrentAnimation.show();
		}
		
		public function hide():void {
			ourCurrentAnimation.hide();
		}
		
		public function stopAndHide():void {
			ourCurrentAnimation.stopAndHide();
		}
		
		public function playAndShow():void {
			ourCurrentAnimation.playAndShow();
		}
		
		public function faceLeft():void {
			ourRightFacingAnimation.stopAndHide();
			ourCurrentAnimation = ourLeftFacingAnimation;
		}

		public function faceRight():void {
			ourLeftFacingAnimation.stopAndHide();
			ourCurrentAnimation = ourRightFacingAnimation;
		}
		
		public function createBody(myWorld:IWorld, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void {
		}
		
		public function destroyBody():void {
		}
		
		public function getFPS():uint {
			return ourCurrentAnimation.getFPS();
		}

		public function setFPS(myFPS:uint):void {
			ourCurrentAnimation.setFPS(myFPS);
		}
	}
}
