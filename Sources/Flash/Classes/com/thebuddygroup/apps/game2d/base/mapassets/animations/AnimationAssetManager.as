package com.thebuddygroup.apps.game2d.base.mapassets.animations {


	public class AnimationAssetManager implements IAnimationAssetManager {
		private var ourAssets:Object;
		
		function AnimationAssetManager(){
			ourAssets	= new Object();
		}
		
		public function getAsset(myAssetName:String):IAnimationAsset {
			return ourAssets[myAssetName];
		}
		
		public function addAsset(myAsset:IAnimationAsset, myAssetName:String):void {
			ourAssets[myAssetName]	= myAsset;
		}
		
		public function removeAsset(myAssetName:String):void{
			delete ourAssets[myAssetName];
		}
		
		public function stopAll() : void {
			for each(var myAsset:IAnimationAsset in ourAssets){
				myAsset.stop();
			}
		}
		
		public function hideAll() : void {
			for each(var myAsset:IAnimationAsset in ourAssets){
				myAsset.stop();
			}
		}
		
		public function stopAndHideAll() : void {
			for each(var myAsset:IAnimationAsset in ourAssets){				
				myAsset.stopAndHide();
			}
		}
		
		public function faceAllLeft():void {
			for each(var myAsset:IAnimationAsset in ourAssets)
				myAsset.faceLeft();			
		}
		
		public function faceAllRight():void {
			for each(var myAsset:IAnimationAsset in ourAssets)
				myAsset.faceRight();			
		}
	}
}
