package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import flash.events.Event;	


	public class AnimationAssetEvent extends Event {
		public static const ANIMATION_START:String		= 'animationStart';
		public static const ANIMATION_STEP:String		= 'animationStep';
		public static const ANIMATION_INTERRUPT:String	= 'animationInterrupt';
		public static const ANIMATION_COMPLETE:String	= 'animationComplete';
		
		public function AnimationAssetEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}