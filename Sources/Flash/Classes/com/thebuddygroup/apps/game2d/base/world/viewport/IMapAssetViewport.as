package com.thebuddygroup.apps.game2d.base.world.viewport 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	


	public interface IMapAssetViewport extends IViewport
	{
		function draw(myMapAsset:IMapAsset):void;
	}
}
