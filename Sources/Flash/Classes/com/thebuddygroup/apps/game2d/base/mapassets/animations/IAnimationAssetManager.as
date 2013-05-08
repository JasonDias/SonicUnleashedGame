package com.thebuddygroup.apps.game2d.base.mapassets.animations {


	public interface IAnimationAssetManager {
		function getAsset(myAssetName:String):IAnimationAsset;
		function addAsset(myAsset:IAnimationAsset, myAssetName:String):void;
		function removeAsset(myAssetName:String):void;
		function stopAll():void;
		function hideAll():void;
		function stopAndHideAll():void;
		function faceAllLeft():void;
		function faceAllRight():void;
	}
}
