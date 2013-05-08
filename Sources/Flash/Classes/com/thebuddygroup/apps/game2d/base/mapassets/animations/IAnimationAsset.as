package com.thebuddygroup.apps.game2d.base.mapassets.animations {
	import flash.events.IEventDispatcher;	
	

	public interface IAnimationAsset {
		function play():void;
		function stop():void;
		function show():void;
		function hide():void;
		function stopAndHide():void;
		function playAndShow():void;
		function faceLeft():void;
		function faceRight():void;
		function getFPS():uint;
		function setFPS(myFPS:uint):void;
		function getDispatcher():IEventDispatcher;
	}
}
