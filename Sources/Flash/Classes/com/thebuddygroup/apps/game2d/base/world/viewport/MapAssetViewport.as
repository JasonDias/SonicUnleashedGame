package com.thebuddygroup.apps.game2d.base.world.viewport 
{
	import com.carlcalderon.arthropod.Debug;	
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;		


	public class MapAssetViewport extends AbstractViewport implements IMapAssetViewport
	{
		protected var ourCurrentWorldPosition:Point;
		protected var ourLastWorldPosition:Point;
		protected var ourLastWorldRotation:Number;
		
		function MapAssetViewport() {
			ourCurrentWorldPosition	= new Point();
			ourLastWorldPosition	= new Point();
			ourLastWorldRotation	= 0;
		}

		public function draw(myMapAsset:IMapAsset):void
		{
			var myDisplayObject:DisplayObject	= myMapAsset.getDisplay();
			var myBody:b2Body					= myMapAsset.getBody();
			if(!myDisplayObject || !myBody) return;
			
			var myWorldUnits:IWorldUnits		= myMapAsset.getWorld().getWorldUnits();
			var myPosition:b2Vec2				= myBody.GetPosition();
			ourCurrentWorldPosition.x			= myPosition.x;
			ourCurrentWorldPosition.y			= myPosition.y;
			var myRotation:Number				= myBody.GetAngle();			
			var myBounds:Rectangle				= getViewpotPixelBounds();
			if(!ourLastWorldPosition.equals(ourCurrentWorldPosition)) {
				myDisplayObject.x					= myWorldUnits.getPixelsFromMeters(ourCurrentWorldPosition.x - ourViewportWorldPosition.x) + myBounds.x + (myBounds.width / 2);	
				myDisplayObject.y					= myWorldUnits.getPixelsFromMeters(ourCurrentWorldPosition.y - ourViewportWorldPosition.y) + myBounds.y + (myBounds.height / 2);
			}
			ourLastWorldPosition				= ourCurrentWorldPosition.clone();
			if(ourLastWorldRotation != myRotation) {
				myDisplayObject.rotation			= (myRotation / Math.PI) * 180;
			}
			ourLastWorldRotation				= myRotation;
			
			var isOffViewport:Boolean			= !myBounds.intersects(myDisplayObject.getRect(myDisplayObject.parent));
			
			//Debug.log(this+': '+myMapAsset+': '+isOffViewport);
			if(isOffViewport){
				myMapAsset.youAreOffTheViewport();
			}else{				
				myMapAsset.youAreOnTheViewport(ourCurrentWorldPosition.x, ourCurrentWorldPosition.y, myRotation);
			}
		}
	}
}