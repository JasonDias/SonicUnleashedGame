package com.thebuddygroup.apps.game2d.base.world.populators {
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	
	import flash.display.DisplayObjectContainer;	
	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	
	import com.thebuddygroup.apps.game2d.IAssetLibrary;	
	

	public interface IWorldPopulator 
	{
		function populate(myAssetLibrary:IAssetLibrary, myWorld:IWorld, myViewport:IMapAssetViewport, myObjectDisplay:DisplayObjectContainer):void;
	}
}
