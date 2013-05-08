package com.thebuddygroup.apps.tilescrollingengine {
	import com.carlcalderon.arthropod.Debug;	
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import com.tbg.util.Range;
	import com.thebuddygroup.apps.game2d.base.identifiers.NumericIdentifier;
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.CyclingActionList;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.EmptyAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.repeatingbitmap.IRepeatingBitmap;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;		

	public class BitmapRepeatingScrollTile extends AbstractMapAsset implements IRepeatingBitmap{
		protected var ourMovementFactor:Point;
		protected var ourBMPData:BitmapData;
		protected var ourLastVisibleRect:Rectangle;
		
		public function BitmapRepeatingScrollTile(){
			super();
			ourMovementFactor	= new Point(1,1);
			ourLastVisibleRect	= new Rectangle();
		}
		
		public function initialize(myBitmap:BitmapData, myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void
		{
			//Debug.log(this + "(init) : "+ myBitmap + " : "+ myViewport);
			ourWorld				= myWorld;
			ourViewport				= myViewport;
			ourBMPData				= myBitmap;
			var mySize:Rectangle	= myViewport.getViewpotPixelBounds();			
			var myTilesX:uint		= Math.max(2, Math.ceil((mySize.width*2)/myBitmap.width));
			var myTilesY:uint		= Math.max(2, Math.ceil((mySize.height*2)/myBitmap.height));
			
			(ourDisplay as Sprite).graphics.beginBitmapFill(ourBMPData);
			(ourDisplay as Sprite).graphics.drawRect(mySize.x,mySize.y,myTilesX*myBitmap.width, myTilesY*myBitmap.height);
			(ourDisplay as Sprite).graphics.endFill();
			
			createBody(myWorld, myX, myY, myRotation);
			myViewport.draw(this);
		}
				
		public function drawRect(myVisibleRect:Rectangle):void{
			//Debug.log(this + "(drawRect) : "+ ourBMPData + " : "+ ourViewport);
			if(myVisibleRect.equals(ourLastVisibleRect))
				return;
			ourLastVisibleRect = myVisibleRect.clone();
			
			var myYOffset:Number		= 800;//this should be the Y position of our hero when on the ground.
			var myX:Number				= myVisibleRect.x * ourMovementFactor.x,
				myY:Number				= (myVisibleRect.y-myYOffset) * ourMovementFactor.y;
			
			
			
			var myMinY:Number			= ourBMPData.height - ourViewport.getViewpotPixelBounds().height;
			var myMaxY:Number			= 0;
			var myYRange:Range			= new Range(myMinY, myMaxY);
			var myWYRange:Range			= new Range(myYOffset * ourMovementFactor.y, -1000);//Note we must guess here about how much he can move up/down in the world in pixel units
			var myYPct:Number			= myWYRange.getPercentAtValue(myY);
			myYPct						= Math.max(0, Math.min(1, myYPct));
			myY							= myYRange.getValueAtPercent(myYPct);
			
			
			var myMovedRect:Rectangle	= this.movedRect;
			if(myX != 0){
				if(myX > 0){
					myMovedRect.x		= myX % ourBMPData.width;
				}else{
					myMovedRect.x		= ourBMPData.width - (Math.abs(myX) % ourBMPData.width);
				}
			}
			if(myY != 0){
				if(myY > 0){
					myMovedRect.y		= myY % ourBMPData.height;
				}else{
					myMovedRect.y		= ourBMPData.height - (Math.abs(myY) % ourBMPData.height);
				}
			}
			this.movedRect				= myMovedRect;
		}
		
		public function get movedRect():Rectangle{
			return ourDisplay.scrollRect || ourViewport.getViewpotPixelBounds().clone();
		}
		
		public function set movedRect(myRect:Rectangle):void{
			if(ourDisplay.scrollRect == null){
				ourDisplay.scrollRect = myRect;
				return;
			}else if(!ourDisplay.scrollRect.equals(myRect)){
				ourDisplay.scrollRect = myRect;
			}
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{
			ourWorld						= myWorld;
			//var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2PolygonDef		= new b2PolygonDef();
			myShapeDef.SetAsBox(1, 1);
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myShapeDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			
			ourBody.m_flags					|= b2Body.e_fixedRotationFlag;
			
			//Recaclulate Mass after all shapes are added to the Body
			//ourBody.SetMassFromShapes();		
		}
		
		public function destroyBody():void
		{
			ourWorld.destroyBody(ourBody);
		}
				
		public function setMovementFactor(myXFactor:Number, myYFactor:Number):void {
			ourMovementFactor.x	= myXFactor;
			ourMovementFactor.y	= myYFactor;
		}		
	}	
}