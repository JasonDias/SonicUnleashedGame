package com.thebuddygroup.apps.game2d.base.mapassets.animations 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AbstractAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	

	public class EmptyAnimationManager extends AbstractAnimationManager implements IAnimationManager 
	{
		public function EmptyAnimationManager(myMapAsset:IMapAsset)
		{
			super(myMapAsset);
		}
		
		public function animate(myAnimationName:String):void {
		}
		
		public function addAnimationRequest(myAnimationRequest:IAnimationRequest):void {
		}
		
		public function removeAnimationRequest(myAnimationRequest:IAnimationRequest):void {
		}		
	}
}
