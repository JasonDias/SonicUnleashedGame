package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import com.carlcalderon.arthropod.Debug;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AbstractAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.stack.IStack;
	import com.thebuddygroup.apps.game2d.base.stack.animation.PersistantSingleStack;
	import com.thebuddygroup.apps.game2d.base.stack.animation.PersistantWeightedStack;	


	public class PlayerCharacterAnimationManager extends AbstractAnimationManager implements IAnimationManager
	{	
		protected var ourCurrentFacingAnimationRequest:IAnimationRequest;
		protected var ourCurrentMovementAnimationRequest:IAnimationRequest;
		
		public function PlayerCharacterAnimationManager(myMapAsset:IMapAsset) {
			super(myMapAsset);			
			
			var myFacingStack:IStack	= new PersistantSingleStack();
			var myMovementStack:IStack	= new PersistantWeightedStack();
			ourAnimationStacks[PlayerCharacterAnimationStateGroups.FACING_STACK]	= myFacingStack;
			ourAnimationStacks[PlayerCharacterAnimationStateGroups.MOVEMENT_STACK]	= myMovementStack;
		}
		
		protected function animate():void{
			var myFacingStack:IStack				= ourAnimationStacks[PlayerCharacterAnimationStateGroups.FACING_STACK];
			var myMovementStack:IStack				= ourAnimationStacks[PlayerCharacterAnimationStateGroups.MOVEMENT_STACK];
			
			var myDesiredFacing:IAnimationRequest	= myFacingStack.getCurrentItem() as IAnimationRequest;
			var myDesiredMovement:IAnimationRequest	= myMovementStack.getCurrentItem() as IAnimationRequest;
			
			//Debug.log(this+' Do Animation: '+myDesiredMovement.getAnimationName(), Debug.GREEN);
			checkThenDoMovementAnimation(myDesiredMovement);
			checkThenDoFacingAnimation(myDesiredFacing);
		}
		
		private function checkThenDoMovementAnimation(myDesiredMovement:IAnimationRequest):void{
			if(myDesiredMovement == ourCurrentMovementAnimationRequest)
				return;
			ourCurrentMovementAnimationRequest	= myDesiredMovement;
			doMovementAnimation();
		}
		
		private function checkThenDoFacingAnimation(myDesiredFacing:IAnimationRequest):void{
			if(myDesiredFacing == ourCurrentFacingAnimationRequest)
				return;
			ourCurrentFacingAnimationRequest = myDesiredFacing;
			doFacingAnimation();
		}
		
		protected function doMovementAnimation():void{
			//To be implemented by subclass
		}
		
		protected function doFacingAnimation():void{
			//To be implemented by subclass
		}

		public function addAnimationRequest(myAnimationRequest:IAnimationRequest):void {
			var myStack:IStack							= ourAnimationStacks[myAnimationRequest.getGroupName()] as IStack;
			//Debug.log(this+' Add request: ' + myAnimationRequest.getAnimationName(), Debug.YELLOW);
			myStack.addItem(myAnimationRequest);
			animate();
		}
		
		public function removeAnimationRequest(myAnimationRequest:IAnimationRequest):void{
			var myStack:IStack							= ourAnimationStacks[myAnimationRequest.getGroupName()] as IStack;
			//Debug.log(this+' Remove request: ' + myAnimationRequest.getAnimationName(), Debug.RED);
			myStack.removeItem(myAnimationRequest);
			animate();
		}
	}
}
