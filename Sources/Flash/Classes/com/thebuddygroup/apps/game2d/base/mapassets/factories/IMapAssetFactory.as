package com.thebuddygroup.apps.game2d.base.mapassets.factories {
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	
	
	import flash.display.DisplayObject;	
	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	

	public interface IMapAssetFactory 
	{
		function createMapAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myDisplayObject:DisplayObject, myX:Number=0, myY:Number=0, myRotation:Number=0):IMapAsset;
		function getAssets():Array;
	}
}
