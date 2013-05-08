package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import com.thebuddygroup.apps.game2d.base.stack.IStack;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	


	public class AbstractAnimationManager 
	{
		protected var ourMapAsset:IMapAsset;
		protected var ourAnimationStacks:Object;
		 
		function AbstractAnimationManager(myMapAsset:IMapAsset){
			ourMapAsset			= myMapAsset;
			ourAnimationStacks	= new Object();
		}
		
		public function getAnimationStack(myState:String):IStack
		{
			return ourAnimationStacks[myState];
		}
		
		public function addAnimationStack(myState:String, myStack:IStack):void 
		{
			ourAnimationStacks[myState] = myStack;
		}
	}
}
