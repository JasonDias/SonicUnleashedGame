package com.thebuddygroup.apps.game2d.base.mapassets.tilemap {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.thebuddygroup.apps.game2d.utils.RLEArrayUtil;		


	public class TileMapData 
	{
		public var map:Array;
		public var rawMap:Array;
		public var tileWidth:uint;
		public var tileHeight:uint;
		public var xTileSpacing:uint	= 0;
		public var yTileSpacing:uint	= 0;
		public var xTileBufferAmount:uint = 0;//ourXTileBufferNumber
		public var yTileBufferAmount:uint = 0;
		public var xTileTotalAmount:uint;//ourTilesX
		public var yTileTotalAmount:uint;
		public var mapRect:Rectangle;
		public var screenBitmapData:BitmapData;
		public var tileSourceBitmapData:BitmapData;
		public var screenBitmap:Bitmap;
		
		public var tmpTileBufferRect:Rectangle;
		public var tmpLastStartCol:uint;
		public var tmpLastEndCol:uint;
		public var tmpLastStartRow:uint;
		public var tmpLastEndRow:uint;
		
		public var tmpForceRedraw:Boolean = true;
		
		function TileMapData(){
			tmpTileBufferRect	= new Rectangle();
		}
		
		public function initialize(myMap:Array, mySourceBitmapData:BitmapData, myTileSize:Rectangle, myViewportSize:Rectangle, myTileBufferAmount:Point=null, myTileSpacing:Point=null):void
		{
			var myRLEUtil:RLEArrayUtil	= new RLEArrayUtil();
			this.rawMap					= myRLEUtil.RLEDecode(myMap);
			
			var myMapColCount:uint		= (rawMap[0] as Array).length;
			var myMapRowCount:uint		= rawMap.length;
			
			myTileBufferAmount			= myTileBufferAmount	|| new Point();
			myTileSpacing				= myTileSpacing			|| new Point();			
			
			this.map					= myMap;
			this.tileSourceBitmapData	= mySourceBitmapData;
			this.tileWidth				= int(myTileSize.width);
			this.tileHeight				= int(myTileSize.height);
			this.xTileBufferAmount		= int(myTileBufferAmount.x);
			this.yTileBufferAmount		= int(myTileBufferAmount.y);
			this.xTileSpacing			= int(myTileSpacing.x);
			this.yTileSpacing			= int(myTileSpacing.y);
			
			//Tiles X/Y Total Amount is the number of tiles we want to draw to fill the buffer
			this.xTileTotalAmount		= Math.min(myMapColCount, Math.ceil((myViewportSize.width)/this.tileWidth) + 2 + this.xTileBufferAmount*2);
			this.yTileTotalAmount		= Math.min(myMapRowCount, Math.ceil((myViewportSize.height)/this.tileHeight) + 2 + this.yTileBufferAmount*2);
			
			this.mapRect				= new Rectangle(0, 0, myMapColCount*this.tileWidth, myMapRowCount*this.tileHeight);
			
			this.screenBitmapData		= new BitmapData(this.tileWidth*this.xTileTotalAmount, this.tileHeight*this.yTileTotalAmount, true, 0x00000000);
			
			this.screenBitmap			= new Bitmap(this.screenBitmapData);
		}		
	}
}