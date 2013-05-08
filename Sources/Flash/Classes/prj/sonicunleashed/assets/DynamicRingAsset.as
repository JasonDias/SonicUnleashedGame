package prj.sonicunleashed.assets {
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	
	import com.carlcalderon.arthropod.Debug;	
	
	import Box2D.Common.Math.b2Vec2;	
	import Box2D.Collision.Shapes.b2CircleDef;	
	import Box2D.Dynamics.b2BodyDef;	
	
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;	
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	
	
	import prj.sonicunleashed.assets.RingAsset;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;

	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Dynamics.b2Body;	


	public class DynamicRingAsset extends RingAsset implements IMapAsset, ICollidable 
	{
		public function DynamicRingAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0)
		{
			super(myWorld, myViewport, myX, myY, myRotation);
		}
		
		override public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2CircleDef		= new b2CircleDef();
			myShapeDef.localPosition		= new b2Vec2(myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5, myWorldUnits.getMetersFromPixels(ourDisplay.height)*0.5);
			myShapeDef.radius				= myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5;
			myShapeDef.density				= .8;
			myShapeDef.friction				= 0.01;
			myShapeDef.restitution			= 0.75;
			myShapeDef.filter.groupIndex	= -1;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.m_flags					|= b2Body.e_fixedRotationFlag;
			ourBody.CreateShape(myShapeDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			
			//Recaclulate Mass after all shapes are added to the Body
			ourBody.SetMassFromShapes();
		}
	}
}
