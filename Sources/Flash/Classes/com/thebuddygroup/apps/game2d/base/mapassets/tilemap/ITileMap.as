package com.thebuddygroup.apps.game2d.base.mapassets.tilemap 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;		


	public interface ITileMap extends IMapAsset, ICollidable
	{
		function getTileMapData():TileMapData;
		function initialize(myWorld:IWorld, myViewport:IMapAssetViewport, myTileMapData:TileMapData, myX:Number=0, myY:Number=0, myRotation:Number=0):void;
	}
}
