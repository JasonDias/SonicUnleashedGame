package com.thebuddygroup.apps.game2d
{
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;	

	public interface IAssetLibrary
	{
		function addAssetFactory(myID:uint, myMapAssetFactory:IMapAssetFactory):void
		function getAssetFactoryByID(myID:uint):IMapAssetFactory;		
	}
}