package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.stack.IWeighted;	


	public class WeightedAnimationRequest extends AnimationRequest implements IAnimationRequest, IWeighted {
		protected var ourWeight:Number;
		public function WeightedAnimationRequest(myGroupName:String, myAnimationName:String, myWeight:Number) {
			super(myGroupName, myAnimationName);
			ourWeight = myWeight;
		}
		
		public function getWeight():Number {
			return ourWeight;
		}
		
		public function setWeight(myWeight:Number):void {
			ourWeight	= myWeight;
		}
	}
}
