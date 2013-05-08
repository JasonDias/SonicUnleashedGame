package com.thebuddygroup.apps.game2d.base.mapassets {
	import flash.utils.getDefinitionByName;
	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;	

	public class MovingPlatform extends AbstractMapAsset implements IMapAsset
	{
		public static const LIB_ASSET_CLASS_NAME:String	= 'LibAssetFloatingPlatform';
		
		function MovingPlatform(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0){
			super();
			init(myWorld, myViewport, myX, myY, myRotation);
		}
		
		private function init(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void{
			ourWorld		= myWorld;
			var myPlatformAssetClass:Class	= getDefinitionByName(MovingPlatform.LIB_ASSET_CLASS_NAME) as Class;
			ourDisplay.addChild(new myPlatformAssetClass());
			createBody(myWorld, myX, myY, myRotation);
			setViewport(myViewport);
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= true;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2PolygonDef		= new b2PolygonDef();
			myShapeDef.SetAsBox(myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5, myWorldUnits.getMetersFromPixels(ourDisplay.height)*0.5);
			
			myShapeDef.density				= 10.1;
			myShapeDef.friction				= 0.8;
			myShapeDef.restitution			= 0.0; 
			 
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myShapeDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			//ourBody.m_linearDamping = .01;
			ourBody.m_flags					= 0x0040;//fix rotation
			//ourBody.SetLinearVelocity(new b2Vec2(-5, 0));
			//Recaclulate Mass after all shapes are added to the Body
			ourBody.SetMassFromShapes();
			
			var myPivotBodyDef:b2BodyDef			= new b2BodyDef();
			myPivotBodyDef.position.Set(myX, myY-6);
			var myPivotBody:b2Body					= ourBody.GetWorld().CreateBody(myPivotBodyDef);
			var myPivotShapeDef:b2CircleDef			= new b2CircleDef();
			myPivotShapeDef.isSensor				= true;
			myPivotShapeDef.radius					= 0.1;
			myPivotShapeDef.density					= 0.01;
			myPivotShapeDef.friction				= 0.3;
			myPivotShapeDef.restitution				= 0.1;
			myPivotBody.CreateShape(myPivotShapeDef);			
			//myPivotBody.SetMassFromShapes();
			
			
			var myPlatformDummyBodyDef:b2BodyDef	= new b2BodyDef();
			myPlatformDummyBodyDef.position.Set(myX, myY);
			var myPlatformDummyBody:b2Body			= ourBody.GetWorld().CreateBody(myPlatformDummyBodyDef);
			myPlatformDummyBody.CreateShape(myPivotShapeDef);
			myPlatformDummyBody.SetMassFromShapes();
			
			
			var myJointDef:b2RevoluteJointDef		= new b2RevoluteJointDef();
			myJointDef.motorSpeed					= -3;
			myJointDef.maxMotorTorque				= 10000000;
			myJointDef.lowerAngle					= 0 * (Math.PI / 180);
			myJointDef.upperAngle					= 270 * (Math.PI / 180);
			myJointDef.referenceAngle				= 0;
			myJointDef.enableMotor					= true;
			myJointDef.enableLimit					= true;						
			myJointDef.Initialize(myPivotBody, myPlatformDummyBody, myPivotBody.GetPosition());
			
			var myDummyJoint:b2RevoluteJoint		= ourBody.GetWorld().CreateJoint(myJointDef) as b2RevoluteJoint;
			//myDummyJoint.m_motorMass				= 30000;
			//myDummyJoint.m_motorForce				= 1000;
			
//			var myPinJointDef:b2DistanceJointDef	= new b2DistanceJointDef();			
//			myPinJointDef.Initialize(myPlatformDummyBody, ourBody, myPlatformDummyBody.GetPosition(), ourBody.GetPosition());
//			myPinJointDef.dampingRatio = 1;
//			
//			var myJoint:b2DistanceJoint				= ourBody.GetWorld().CreateJoint(myPinJointDef) as b2DistanceJoint;
			
			
		}
		
		public function destroyBody():void
		{
			ourWorld.destroyBody(ourBody);
		}		
	}
}
