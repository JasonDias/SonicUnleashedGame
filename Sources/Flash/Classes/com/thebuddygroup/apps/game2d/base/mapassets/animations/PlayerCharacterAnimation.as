package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;			


	public class PlayerCharacterAnimation 
	{
		public static const IDLE:String			= 'idle';
		public static const JUMP:String			= 'jump';
		public static const RUN:String			= 'run';
		public static const SUPER_RUN:String	= 'superRun';
		public static const HIT:String			= 'hit';
		public static const RING:String			= 'ring';
		public static const SUPER_JUMP:String	= 'superJump';
		public static const DANCE:String		= 'dance';
		public static const ATTACK:String		= 'attack';
		public static const CLIMB:String		= 'climb';
		
		public static const FACE_LEFT:String	= 'faceLeft';
		public static const FACE_RIGHT:String	= 'faceRight';
		
		private static var ourInstance:PlayerCharacterAnimation;
		
		public static function getInstance():PlayerCharacterAnimation{
			if(!ourInstance){
				ourInstance = new PlayerCharacterAnimation();
			}
			return ourInstance;
		}
		
		private var ourAnimationRequests:Object;
		
		function PlayerCharacterAnimation(){
			ourAnimationRequests	= new Object();
			ourAnimationRequests[PlayerCharacterAnimation.FACE_LEFT]	= new AnimationRequest(PlayerCharacterAnimationStateGroups.FACING_STACK, PlayerCharacterAnimation.FACE_LEFT);
			ourAnimationRequests[PlayerCharacterAnimation.FACE_RIGHT]	= new AnimationRequest(PlayerCharacterAnimationStateGroups.FACING_STACK, PlayerCharacterAnimation.FACE_RIGHT);
			
			var myWeight:Number = 0;
			ourAnimationRequests[PlayerCharacterAnimation.IDLE]			= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.IDLE, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.RUN]			= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.RUN, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.SUPER_RUN]	= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.SUPER_RUN, myWeight++);
			
			ourAnimationRequests[PlayerCharacterAnimation.ATTACK]		= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.ATTACK, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.CLIMB]		= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.CLIMB, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.JUMP]			= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.JUMP, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.SUPER_JUMP]	= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.SUPER_JUMP, myWeight++);
			
			ourAnimationRequests[PlayerCharacterAnimation.RING]			= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.RING, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.DANCE]		= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.DANCE, myWeight++);
			ourAnimationRequests[PlayerCharacterAnimation.HIT]			= new WeightedAnimationRequest(PlayerCharacterAnimationStateGroups.MOVEMENT_STACK, PlayerCharacterAnimation.HIT, myWeight++);
		}
		
		public function getAnimationRequest(myAnimationName:String):IAnimationRequest{
			return ourAnimationRequests[myAnimationName];
		}		
	}
}
