package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;		


	public class AnimationRequest implements IAnimationRequest {
		protected var ourGroupName:String;
		protected var ourAnimationName:String;
		
		public function AnimationRequest(myGroupName:String, myAnimationName:String){
			ourGroupName		= myGroupName;
			ourAnimationName	= myAnimationName;
		}
		
		public function getGroupName():String {
			return ourGroupName;
		}
		
		public function getAnimationName():String {
			return ourAnimationName;
		}

		public function setGroupName(myName:String):void {
			ourGroupName	= myName;
		}

		public function setAnimationName(myName:String):void {
			ourAnimationName	= myName;
		}
	}
}
