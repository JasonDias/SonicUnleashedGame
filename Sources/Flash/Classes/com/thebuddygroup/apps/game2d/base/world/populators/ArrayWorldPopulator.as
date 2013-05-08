package com.thebuddygroup.apps.game2d.base.world.populators {
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;	
	
	import flash.display.Sprite;	
	import flash.display.DisplayObjectContainer;	
	
	import Box2D.Dynamics.b2Body;	
	
	import com.carlcalderon.arthropod.Debug;	
	import com.thebuddygroup.apps.game2d.IAssetLibrary;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	
	import Box2D.Common.Math.b2Vec2;		

	public class ArrayWorldPopulator implements IWorldPopulator
	{
		private var ourMapArray:Array;
		private var ourTileW:uint;
		private var ourTileH:uint;
		
		function ArrayWorldPopulator(myMapArray:Array, myTileW:uint, myTileH:uint):void{
			ourMapArray = myMapArray;
			ourTileW	= myTileW;
			ourTileH	= myTileH;
		}
		
		public function populate(myAssetLibrary:IAssetLibrary, myWorld:IWorld, myViewport:IMapAssetViewport, myDisplayObject:DisplayObjectContainer):void
		{
			//TODO: Experimental code
			//myDisplayObject	= myViewport.getDisplay() as DisplayObjectContainer;
			
			//loop here and add to world
			var myMapAssetFactory:IMapAssetFactory,
			myMapAsset:IMapAsset,
			myWorldUnits:IWorldUnits	= myWorld.getWorldUnits(),
			i:uint,
			j:uint,
			tileIdx:int,
			tileX:Number,
			tileY:Number,
			rowCount:uint				= ourMapArray.length,
			colCount:uint				= (ourMapArray[0] as Array).length;
			
			for(i=0; i < rowCount; i++){
	            for(j=0; j < colCount; j++){
	            	tileIdx		= int(ourMapArray[i][j]);
	            	   	
	            	if(tileIdx == 0)
	            		continue;
	            	
	            	tileX				= myWorldUnits.getMetersFromPixels(j*ourTileW);
	            	tileY				= myWorldUnits.getMetersFromPixels(i*ourTileH);
	            	myMapAssetFactory	= myAssetLibrary.getAssetFactoryByID(tileIdx);
	            	if(!myMapAssetFactory)
	            		continue;
	            		
	            	myMapAsset			= myMapAssetFactory.createMapAsset(myWorld, myViewport, myDisplayObject, tileX, tileY, 0);
	            	
	            	myWorld.addMapAsset(myMapAsset);
	            			            	myMapAsset.update();
	            	myDisplayObject.addChild(myMapAsset.getDisplay());
				}
			}
		}
	}
}