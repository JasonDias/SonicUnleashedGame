package com.thebuddygroup.apps.game2d.base.world.viewport {
	import flash.display.DisplayObjectContainer;	
	import flash.display.DisplayObject;	
	
	import com.tbg.gui.IPlaceable;	
	
	import flash.geom.Point;	
	import flash.geom.Rectangle;	


	public interface IViewport extends IPlaceable 
	{
		function setViewportPixelBounds(myBounds:Rectangle):void;
		function setViewportWorldPosition(myWorldX:Number, myWorldY:Number):void;
		
		function getViewpotPixelBounds():Rectangle;
		function getViewportWorldPosition():Point;
		
		
		function setDisplay(myDisplay:DisplayObjectContainer):void;
		function getDisplay():DisplayObjectContainer;	
	}
}
