package prj.sonicunleashed.collidable 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;	
	
	import prj.sonicunleashed.actions.factories.SonicActionFactory;	
	
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import prj.sonicunleashed.events.SonicClimbEvent;
	
	import com.carlcalderon.arthropod.Debug;
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;	

	public class SonicClimbArm extends AbstractMapAsset implements IMapAsset, ICollidable
	{
		private var ourCollisionManager:ICollisionManager;
		
		function SonicClimbArm(myActionFactory:IActionFactory, myWorld:IWorld, myX:Number = 0, myY:Number = 0, myRotation:Number = 0) {
			ourActionFactory			= myActionFactory;
			ourCollisionManager			= new CollisionManager(this as ICollidable);
			createBody(myWorld, myX, myY, myRotation);
		}

		public function collisionOccurred(myCollidable:ICollidable):void {
			//Debug.log(this+' climb arm hit platform ' + myCollidable);
			
			
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			ourDispatcher.dispatchEvent(new SonicClimbEvent(SonicClimbEvent.HIT_PLATFORM));
			//ActionsFacade.getInstance().addActionAndStart(PlayerCharacterActions.CLIMB_ACTION, myCollidedAsset);
			
			//getSoundManager().playSound(RingAsset.LIB_ASSET_RING_SOUND_CLASS_NAME);
			
			//ourFramesPassedSinceCollision = 0;
			//deleteSelf();
		}		
		
		public function getCollisionManager():ICollisionManager {
			return ourCollisionManager;
		}		
		
		public function createBody(myWorld:IWorld, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void {
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= false;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2CircleDef		= new b2CircleDef();
			myShapeDef.density				= 0.001;
			myShapeDef.friction				= 0.1;
			myShapeDef.restitution			= 0.0;
			//myShapeDef.localPosition		= new b2Vec2(0, myWorldUnits.getMetersFromPixels(20)*0.5);
			myShapeDef.radius				= myWorldUnits.getMetersFromPixels(40)*0.5;
			myShapeDef.isSensor				= true;
			myShapeDef.filter.groupIndex	= -667;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myShapeDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);			
			ourBody.m_flags					|= b2Body.e_fixedRotationFlag;
			
			//Recaclulate Mass after all shapes are added to the Body
			ourBody.SetMassFromShapes();
		}
		
		public function destroyBody():void {
		}		
	}
}
