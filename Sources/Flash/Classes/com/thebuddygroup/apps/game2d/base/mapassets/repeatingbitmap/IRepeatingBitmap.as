package com.thebuddygroup.apps.game2d.base.mapassets.repeatingbitmap {
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	
	
	import flash.geom.Rectangle;	
	import flash.display.BitmapData;	
	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	

	public interface IRepeatingBitmap extends IMapAsset
	{
		function initialize(myBitmap:BitmapData, myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0):void;
		function drawRect(myVisibleRect:Rectangle):void;
		function setMovementFactor(myXFactor:Number, myYFactor:Number):void;
	}
}
