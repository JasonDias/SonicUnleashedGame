package com.thebuddygroup.apps.game2d.base.world.viewport {
	import com.thebuddygroup.apps.game2d.base.mapassets.repeatingbitmap.IRepeatingBitmap;	
	
	import flash.geom.Rectangle;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.AbstractViewport;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;		


	public class RepeatingBitmapViewport extends AbstractViewport implements IMapAssetViewport
	{
		private var ourLastPixelBounds:Rectangle;
		
		public function RepeatingBitmapViewport()
		{
			ourLastPixelBounds			= new Rectangle();
		}
		
		public function draw(myMap:IMapAsset):void
		{
			var myRepeatingBitmap:IRepeatingBitmap	= myMap as IRepeatingBitmap;
			
			if(!myRepeatingBitmap)
				throw new Error("A " + this + " can only draw IRepeatingBitmaps"); 
			
			var myWorldUnits:IWorldUnits			= myRepeatingBitmap.getWorld().getWorldUnits();
			var myBody:b2Body						= myRepeatingBitmap.getBody();
			var myPosition:b2Vec2					= myBody.GetPosition();
			var myWorldX:Number						= myPosition.x;
			var myWorldY:Number						= myPosition.y;
			//var myRotation:Number					= myBody.GetAngle();
			var myBounds:Rectangle					= getViewpotPixelBounds();
			
			var myX:Number							= Math.round(myWorldUnits.getPixelsFromMeters(myWorldX + ourViewportWorldPosition.x) - (myBounds.width / 2));
			var myY:Number							= Math.round(myWorldUnits.getPixelsFromMeters(myWorldY + ourViewportWorldPosition.y) - (myBounds.height / 2));
			var myW:Number							= myBounds.width;
			var myH:Number							= myBounds.height;
			
			var myVisibleRect:Rectangle				= new Rectangle(myX, myY, myW, myH);
			if(myVisibleRect.equals(ourLastPixelBounds))
				return;
			ourLastPixelBounds = myVisibleRect.clone();			
			myRepeatingBitmap.drawRect(myVisibleRect);		
		}
	}
}
