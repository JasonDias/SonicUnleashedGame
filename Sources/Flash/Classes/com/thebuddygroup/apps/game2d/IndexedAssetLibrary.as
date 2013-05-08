package com.thebuddygroup.apps.game2d
{
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;	

	public class IndexedAssetLibrary implements IAssetLibrary
	{
		private var ourAssetFactories:Object;
		private var ourAssets:Array;
		
		function IndexedAssetLibrary():void{
			ourAssets				= new Array();
			ourAssetFactories		= new Array();
		}
		
		public function getAssetFactoryByID(myID:uint):IMapAssetFactory{
			return ourAssetFactories[myID];			
		}
		
		
		public function addAssetFactory(myID:uint, myMapAssetFactory:IMapAssetFactory):void
		{
			ourAssetFactories[myID]	= myMapAssetFactory;
		}
		
	}
}