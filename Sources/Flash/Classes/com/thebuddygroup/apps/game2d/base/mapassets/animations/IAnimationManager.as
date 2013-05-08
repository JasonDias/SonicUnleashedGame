package com.thebuddygroup.apps.game2d.base.mapassets.animations 
{
	import com.thebuddygroup.apps.game2d.base.stack.IStack;	
	

	public interface IAnimationManager 
	{
		function addAnimationRequest(myAnimationRequest:IAnimationRequest):void;
		function removeAnimationRequest(myAnimationRequest:IAnimationRequest):void;
		function getAnimationStack(myState:String):IStack;
		function addAnimationStack(myState:String, myStack:IStack):void;
	}
}
