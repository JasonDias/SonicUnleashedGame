package com.thebuddygroup.apps.tilescrollingengine 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;	
	
	import flash.display.*;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.ITileMap;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.TileMapData;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	
	import Box2D.Collision.Shapes.b2FilterData;		

	public class TileMap extends AbstractMapAsset implements ITileMap{
		private var ourTileMapData:TileMapData;
		protected var ourCollisionManager:ICollisionManager;

		public function TileMap() {
			super();
			ourCollisionManager = new CollisionManager(this);
		}
		
		public function initialize(myWorld:IWorld, myViewport:IMapAssetViewport, myTileMapData:TileMapData, myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			ourWorld				= myWorld;
			ourViewport				= myViewport;
			ourTileMapData			= myTileMapData;
			
			ourDisplay.addChild(ourTileMapData.screenBitmap);
			ourWorld = myWorld;
			createBody(myWorld, myX, myY, myRotation);
		}
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.userData				= this;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			
			applyMapToBody();	
		}
		
		public function destroyBody():void
		{
			ourWorld.destroyBody(ourBody);
		}
				
		public function applyMapToBody():void{
			
			var myMap:Array				= ourTileMapData.map,
				myShapeDef:b2PolygonDef	= new b2PolygonDef(),
				myWorldUnits:IWorldUnits= ourWorld.getWorldUnits(),
				myTileW:Number			= myWorldUnits.getMetersFromPixels(ourTileMapData.tileWidth) * 0.5,
				myTileH:Number			= myWorldUnits.getMetersFromPixels(ourTileMapData.tileHeight) * 0.5,
				myTileX:Number,
				myTileY:Number,
				myRow:uint,
				myCol:uint,
				myNextX:Number,
				myValue:uint,
				myLength:uint,
				myCurrentBits:uint,				
				myMapRowCount:uint	= myMap.length,
				myMapColCount:uint,
				myOutputArray:Array	= new Array();
			
			for(myRow=0; myRow < myMapRowCount; myRow++){
				myMapColCount	= myMap[myRow].length;
				myCurrentBits	= 0;
				myOutputArray[myRow]	= new Array();
				myNextX	= 0;
				
				for(myCol=0; myCol < myMapColCount; myCol++){
					myCurrentBits	= uint(myMap[myRow][myCol]);
					myLength		= myCurrentBits >> 8;
					myValue			= myCurrentBits - (myLength << 8);
					if(myValue == 0){
						myNextX += myTileW*2*myLength;
						continue;
					}
					myTileX	= myNextX + (myTileW*myLength);
	            	myTileY	= (myRow*myTileH*2)+myTileH;
	            	myShapeDef.SetAsOrientedBox(myTileW*myLength, myTileH, new b2Vec2(myTileX, myTileY), 0);
	            	
	            	//myShapeDef.density				= 1.0;
					myShapeDef.friction					= .2;
					//myShapeDef.
					//myShapeDef.restitution			= 0.0;
					myShapeDef.filter.groupIndex		= -667; 
	            	
	            	
					ourBody.CreateShape(myShapeDef);
					myNextX += myTileW*2*myLength;
	            }
			}
		}
		
		public function getTileMapData():TileMapData
		{
			return ourTileMapData;
		}
		
		public function collisionOccurred(myCollidable:ICollidable):void {
		}
		
		public function getCollisionManager():ICollisionManager {
			return ourCollisionManager;
		}		
	}
}