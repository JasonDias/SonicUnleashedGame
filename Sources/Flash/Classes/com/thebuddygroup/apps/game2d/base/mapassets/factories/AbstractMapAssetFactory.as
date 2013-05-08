package com.thebuddygroup.apps.game2d.base.mapassets.factories 
{


	public class AbstractMapAssetFactory 
	{
		protected var ourAssets:Array;
		
		function AbstractMapAssetFactory(){
			ourAssets	= new Array();
		}
		
		public function getAssets():Array
		{
			return ourAssets;
		}
	}
}
