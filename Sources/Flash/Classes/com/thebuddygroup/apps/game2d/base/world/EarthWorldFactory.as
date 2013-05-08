package com.thebuddygroup.apps.game2d.base.world 
{
	import Box2D.Dynamics.b2Body;	
	import Box2D.Collision.Shapes.b2PolygonDef;	
	import Box2D.Dynamics.b2BodyDef;	
	
	import flash.geom.Rectangle;
	
	import com.tbg.util.Conversion;
	import com.thebuddygroup.apps.game2d.World;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.render.IWorldRenderer;
	import com.thebuddygroup.apps.game2d.base.world.render.WorldRenderer;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;		


	public class EarthWorldFactory implements IWorldFactory 
	{
		public function createWorld(myBoundsRectInMeters:Rectangle):IWorld
		{
			var myWorldConstraints:b2AABB			= new b2AABB();
			myWorldConstraints.lowerBound.Set(myBoundsRectInMeters.left, myBoundsRectInMeters.top);
			myWorldConstraints.upperBound.Set(myBoundsRectInMeters.right, myBoundsRectInMeters.bottom);
			
			var gravityVector:b2Vec2				= new b2Vec2(0.00, 50);
			var objectsDoSleepWhenNotMoving:Boolean	= true;
			var myb2World:b2World					= new b2World(myWorldConstraints, gravityVector, objectsDoSleepWhenNotMoving);
			createWorldBoundary(myb2World, myBoundsRectInMeters);
			
			var myPixels:Number						= 64;
			var myMeters:Number						= 1;
			var myUnitConversion:Conversion			= new Conversion(0, 0, myPixels, myMeters);
			var myWorldUnits:IWorldUnits			= new WorldUnits(myUnitConversion);
			var myTimeStep:Number					= 1.00/45.00;
			var myIterationsPerStep:uint			= 8;
			var myFPS:Number						= 60;
			
			var myWorld:IWorld 						= new World(this, myb2World, myWorldUnits, myTimeStep, myIterationsPerStep);
			var myRenderer:IWorldRenderer			= new WorldRenderer(myWorld, myFPS);
			
			myWorld.setRenderer(myRenderer);
			//myWorld.startRendering();			
			
			return myWorld;
		}
		
		private function createWorldBoundary(myb2World:b2World, myBoundsRectInMeters:Rectangle):void{
			var myBodyDef:b2BodyDef			= new b2BodyDef();
			myBodyDef.allowSleep			= false;
			myBodyDef.isSleeping			= false;
			myBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			
			var myBody:b2Body				= myb2World.CreateBody(myBodyDef);
			
			var myShapeDef:b2PolygonDef		= new b2PolygonDef();
			myShapeDef.density				= 0.001;
			myShapeDef.friction				= 1;
			myShapeDef.restitution			= 0.0;
			
			//left wall			
			myShapeDef.SetAsOrientedBox(1, myBoundsRectInMeters.height*0.5, new b2Vec2(myBoundsRectInMeters.left+1, myBoundsRectInMeters.top + myBoundsRectInMeters.height*0.5));
			myBody.CreateShape(myShapeDef);
			//right wall			
			myShapeDef.SetAsOrientedBox(1, myBoundsRectInMeters.height*0.5, new b2Vec2(myBoundsRectInMeters.right-1, myBoundsRectInMeters.top + myBoundsRectInMeters.height*0.5));
			myBody.CreateShape(myShapeDef);
			//top wall
			myShapeDef.SetAsOrientedBox(myBoundsRectInMeters.width*0.5, 1, new b2Vec2(myBoundsRectInMeters.left + myBoundsRectInMeters.width*0.5, myBoundsRectInMeters.top+1));
			myBody.CreateShape(myShapeDef);	
			//bottom wall
			myShapeDef.SetAsOrientedBox(myBoundsRectInMeters.width*0.5, 1, new b2Vec2(myBoundsRectInMeters.left + myBoundsRectInMeters.width*0.5, myBoundsRectInMeters.bottom-1));
			myBody.CreateShape(myShapeDef);	
		}
	}
}
