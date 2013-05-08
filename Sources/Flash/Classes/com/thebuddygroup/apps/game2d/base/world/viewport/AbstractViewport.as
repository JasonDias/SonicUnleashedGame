package com.thebuddygroup.apps.game2d.base.world.viewport 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;		


	public class AbstractViewport extends EventDispatcher 
	{
		protected var ourPixelBounds:Rectangle;
		protected var ourViewportWorldPosition:Point;
		protected var ourDisplay:DisplayObjectContainer;
		
		function AbstractViewport()
		{
			ourPixelBounds				= new Rectangle();
			ourViewportWorldPosition	= new Point();
		}

		public function setX(myValue:Number):void
		{
			if(ourPixelBounds.x == myValue)
				return;
			ourPixelBounds.x	= myValue;
			updateScrollRect();
		}
		
		public function setY(myValue:Number):void
		{
			if(ourPixelBounds.y == myValue)
				return;
			ourPixelBounds.y	= myValue;
			updateScrollRect();
		}
		
		public function getX():Number
		{
			return ourPixelBounds.x;
		}
		
		public function getY():Number
		{
			return ourPixelBounds.y;
		}
		
		public function getWidth():Number
		{
			return ourPixelBounds.width;
		}

		public function getHeight():Number
		{
			return ourPixelBounds.height;
		}

		public function setWidth(myWidth:Number):void
		{
			if(ourPixelBounds.width == myWidth)
				return;
			ourPixelBounds.width	= myWidth;
			updateScrollRect();
		}
		
		public function setHeight(myHeight:Number):void
		{
			if(ourPixelBounds.height == myHeight)
				return;
			ourPixelBounds.height	= myHeight;
			updateScrollRect();
		}
		
		public function getViewpotPixelBounds():Rectangle
		{
			return ourPixelBounds;
		}

		public function getViewportWorldPosition():Point
		{
			return ourViewportWorldPosition;
		}
		
		public function setViewportWorldPosition(myWorldX:Number, myWorldY:Number):void
		{
			if(ourViewportWorldPosition.x != myWorldX)
				ourViewportWorldPosition.x	= myWorldX;
			if(ourViewportWorldPosition.y != myWorldY)
				ourViewportWorldPosition.y	= myWorldY; 
		}
		
		public function setViewportPixelBounds(myBounds:Rectangle):void
		{
			if(ourPixelBounds.equals(myBounds))
				return;
			ourPixelBounds			= myBounds;
			updateScrollRect();
		}
		
		public function setDisplay(myDisplay:DisplayObjectContainer):void
		{
			if(ourDisplay == myDisplay)
				return;
			ourDisplay	= myDisplay;
			updateScrollRect();
		}
		
		public function getDisplay():DisplayObjectContainer
		{
			return ourDisplay;
		}
		
		private function updateScrollRect():void
		{			
			if(ourDisplay && ourPixelBounds){
				ourDisplay.scrollRect	= new Rectangle(0, 0, ourPixelBounds.width, ourPixelBounds.height);
			}
		}
	}
}
