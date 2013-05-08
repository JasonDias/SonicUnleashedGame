package com.thebuddygroup.apps.game2d.base.world.viewport {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	
	import Box2D.Common.Math.b2Vec2;	
	import Box2D.Dynamics.b2Body;	
	
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;	
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.ITileMap;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.TileMapData;		


	public class BitmapTileMapViewport extends AbstractViewport implements IMapAssetViewport 
	{
		private var ourLastPixelBounds:Rectangle;
		
		//special private prop just for local storage of TileMap props
		private var ourCurrentTileMapData:TileMapData;
		
		function BitmapTileMapViewport(){
			ourLastPixelBounds			= new Rectangle();
		}
		

		public function draw(myMapAsset:IMapAsset):void
		{
			
			var myTileMap:ITileMap				= myMapAsset as ITileMap; 
			 
			//We're going to cache the tilemap values in our class so we can make multiple separate function calls in series without looking up the values again from the tilemap
			ourCurrentTileMapData				= myTileMap.getTileMapData();
			
			var myWorldUnits:IWorldUnits		= myTileMap.getWorld().getWorldUnits();
			var myBody:b2Body					= myTileMap.getBody();
			var myPosition:b2Vec2				= myBody.GetPosition();
			var myWorldX:Number					= myPosition.x;
			var myWorldY:Number					= myPosition.y;
			//var myRotation:Number				= myBody.GetAngle();
			var myBounds:Rectangle				= getViewpotPixelBounds();
			
			var myX:Number						= Math.round(myWorldUnits.getPixelsFromMeters(myWorldX + ourViewportWorldPosition.x) - (myBounds.width / 2));
			var myY:Number						= Math.round(myWorldUnits.getPixelsFromMeters(myWorldY + ourViewportWorldPosition.y) - (myBounds.height / 2));
			var myW:Number						= myBounds.width;
			var myH:Number						= myBounds.height;
			
			var myVisibleRect:Rectangle			= new Rectangle(myX, myY, myW, myH);
			drawTileMap(myVisibleRect);
		}
				
		private function drawTileMap(myVisibleRect:Rectangle):void{
			//cache stuff
			//var myMapRect:Rectangle		= ourCurrentTileMapData.mapRect;
			
			
			//My Visible Rect is the desired view of the map
			//Removed because we now require visible rect to be passed in
			//myVisibleRect				= myVisibleRect || new Rectangle(0, 0, ourTilesX*ourTileSize.x, ourTilesY*ourTileSize.y);
			
			//Adjust visible rect to fit within bounds
			//myVisibleRect.x				= Math.min(Math.max(myVisibleRect.x, myMapRect.left), myMapRect.right-myVisibleRect.width);
			//myVisibleRect.y				= Math.min(Math.max(myVisibleRect.y, myMapRect.top), myMapRect.bottom-myVisibleRect.height);
			
			//check to see if this is diff than the last frame
			if(!ourCurrentTileMapData.tmpForceRedraw && ourLastPixelBounds.equals(myVisibleRect)){
				return;
			}	
					
			ourLastPixelBounds = myVisibleRect.clone();		
			
			var myMap:Array			= ourCurrentTileMapData.rawMap,
				xOffset:int,
				yOffset:int,
				myMapRowCount:uint	= myMap.length,
				myMapColCount:uint	= (myMap[0] as Array).length;						
			
			if(!ourCurrentTileMapData.tmpTileBufferRect.containsRect(myVisibleRect)){
				var startCol:uint	= Math.max(0, Math.floor(myVisibleRect.left/ourCurrentTileMapData.tileWidth) - ourCurrentTileMapData.xTileBufferAmount); 
				var endCol:uint		= Math.min(myMapColCount, startCol+ourCurrentTileMapData.xTileTotalAmount);
				
				var startRow:uint	= Math.max(0, Math.floor(myVisibleRect.top/ourCurrentTileMapData.tileHeight) - ourCurrentTileMapData.yTileBufferAmount);
				var endRow:uint		= Math.min(myMapRowCount, startRow+ourCurrentTileMapData.yTileTotalAmount);
				
				drawTiles(startCol, endCol, startRow, endRow);
			}
			
			var myTileBufferRect:Rectangle	= ourCurrentTileMapData.tmpTileBufferRect;
			xOffset							= myVisibleRect.left - myTileBufferRect.left;
			yOffset							= myVisibleRect.top - myTileBufferRect.top;
			
			var myScrollRect:Rectangle						= new Rectangle(xOffset, yOffset, myVisibleRect.width, myVisibleRect.height);
			ourCurrentTileMapData.screenBitmap.scrollRect	= myScrollRect;
			
			ourCurrentTileMapData.tmpForceRedraw			= false;			
		}
		
		private function drawTiles(myStartCol:uint, myEndCol:uint, myStartRow:uint, myEndRow:uint):void{
			//Our TileBufferRect in Map Space just like the Visible Rect
			var myTileBufferRect:Rectangle	= ourCurrentTileMapData.tmpTileBufferRect;		
			myTileBufferRect.x				= myStartCol * ourCurrentTileMapData.tileWidth;
			myTileBufferRect.y				= myStartRow * ourCurrentTileMapData.tileHeight;
			myTileBufferRect.width			= (myEndCol - myStartCol) * ourCurrentTileMapData.tileWidth;
			myTileBufferRect.height			= (myEndRow - myStartRow) * ourCurrentTileMapData.tileHeight;
			
			if(!ourCurrentTileMapData.tmpForceRedraw && ourCurrentTileMapData.tmpLastStartCol == myStartCol && ourCurrentTileMapData.tmpLastEndCol == myEndCol && ourCurrentTileMapData.tmpLastStartRow == myStartRow && ourCurrentTileMapData.tmpLastEndRow)
				return;
			
			ourCurrentTileMapData.tmpLastStartCol	= myStartCol;
			ourCurrentTileMapData.tmpLastEndCol		= myEndCol;
			ourCurrentTileMapData.tmpLastStartRow	= myStartRow;
			ourCurrentTileMapData.tmpLastEndRow		= myEndRow;
			
			//trace('+++++++++++++++++++\nWe are really drawing now\n+++++++++++++++');
			var myScreenBitmapData:BitmapData		= ourCurrentTileMapData.screenBitmapData,
				myMap:Array							= ourCurrentTileMapData.rawMap,
				myMapRowCount:uint					= myMap.length,
				//myMapColCount:uint					= (myMap[0] as Array).length,
				myTileWidth:uint					= ourCurrentTileMapData.tileWidth,
				myTileHeight:uint					= ourCurrentTileMapData.tileHeight,
				myTileSourceBitmapData:BitmapData	= ourCurrentTileMapData.tileSourceBitmapData,
				myXTileSpacing:uint					= ourCurrentTileMapData.xTileSpacing,
				myYTileSpacing:uint					= ourCurrentTileMapData.yTileSpacing,
				myRowCtr:uint,
				myColCtr:uint,
				myTileNum:int,
				myDestX:int,
				myDestY:int,
				mySourceX:int,
				mySourceY:int,
				i:int,
				j:int;
			
			myScreenBitmapData.lock();
			myScreenBitmapData.fillRect(myScreenBitmapData.rect, 0x00000000);				
			for(i=0, myRowCtr=myStartRow; myRowCtr < myEndRow; myRowCtr++, i++){	            
	            for(j=0, myColCtr=myStartCol; myColCtr < myEndCol; myColCtr++, j++){
	            	myTileNum		= int(myMap[myRowCtr][myColCtr])-1;
	            	
	            	if(myTileNum < 0)
	            		continue;
	            	
	                //where to put this in the screen
	                myDestX		= j*(myTileWidth);
	                myDestY		= i*(myTileHeight);	                
	                
	                //get tile from map
	                mySourceX		= (myTileNum % myMapRowCount)*(myTileWidth+myXTileSpacing);
	                //Todo, this looks a little fishy, why doesn't this need the myMapColCount???!?!?!?!?!!?
	                mySourceY		= (Math.floor(myTileNum/myMapRowCount))*(myTileHeight+myYTileSpacing);
	                
	                //copy pixels into screen bitmap for this tile
	                myScreenBitmapData.copyPixels(myTileSourceBitmapData, new Rectangle(mySourceX, mySourceY, myTileWidth, myTileHeight), new Point(myDestX, myDestY));
	            }
	        }
	        myScreenBitmapData.unlock();
		}
	}
}
