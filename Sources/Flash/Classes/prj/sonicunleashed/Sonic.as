package prj.sonicunleashed 
{
	import flash.utils.setTimeout;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;	
	
	import prj.sonicunleashed.events.SonicClimbEvent;	
	import prj.sonicunleashed.collidable.SonicClimbArm;	
	import prj.sonicunleashed.events.SonicFistEvent;	
	
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	
	import com.thebuddygroup.apps.game2d.base.stack.IStack;	
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimationStateGroups;	
	
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2JointEdge;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import prj.sonicunleashed.actions.factories.SonicActionFactory;
	import prj.sonicunleashed.animations.SonicAnimationManager;
	import prj.sonicunleashed.assets.GrindRailCutScene;
	import prj.sonicunleashed.assets.factories.SelfDestructingDynamicRingAssetFactory;
	import prj.sonicunleashed.sound.SonicSoundManager;
	
	import com.carlcalderon.arthropod.Debug;
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.tilescrollingengine.*;
	
	import flash.display.*;
	import flash.utils.getDefinitionByName;
	
	import Box2D.Collision.Shapes.b2ShapeDef;
	
	import prj.sonicunleashed.collidable.SonicFist;
	
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2FilterData;		

	public class Sonic extends AbstractPlayerCharacter implements IPlayerCharacter {
		public static const ANIMATION_ASSET_IDLE:String					= 'AnimationAssetIdle';
		public static const ANIMATION_ASSET_RUN:String					= 'AnimationAssetRun';
		public static const ANIMATION_ASSET_JUMP:String					= 'AnimationAssetJump';
		public static const ANIMATION_ASSET_SUPER_RUN:String			= 'AnimationAssetSuperRun';
		public static const ANIMATION_ASSET_BOOST_EFFECT:String			= 'AnimationAssetBoostEffect';
		public static const ANIMATION_ASSET_HIT:String					= 'AnimationAssetHit';
		public static const ANIMATION_ASSET_CLIMB:String				= 'AnimationAssetClimb';
		public static const ANIMATION_ASSET_DANCE:String				= 'AnimationAssetDance';
		public static const ANIMATION_ASSET_ATTACK:String				= 'AnimationAssetAttack';
				
		public static const LIB_ASSET_IDLE_LEFT_ANIM_CLASS_NAME:String	= 'LibAssetSonicIdleLeftBitmap';
		public static const LIB_ASSET_IDLE_RIGHT_ANIM_CLASS_NAME:String	= 'LibAssetSonicIdleRightBitmap';
		public static const LIB_ASSET_RUN_ANIM_CLASS_NAME:String		= 'LibAssetSonicRunBitmap';
		public static const LIB_ASSET_JUMP_ANIM_CLASS_NAME:String		= 'LibAssetSonicJumpBitmap';
		public static const LIB_ASSET_SUPER_RUN_ANIM_CLASS_NAME:String	= 'LibAssetSonicSuperRunBitmap';
		public static const LIB_ASSET_BOOST_EFFECT_ANIM_CLASS_NAME:String= 'LibAssetSonicBoostEffectBitmap';
		public static const LIB_ASSET_HIT_ANIM_CLASS_NAME:String		= 'LibAssetSonicHitBitmap';
		public static const LIB_ASSET_CLIMB_ANIM_CLASS_NAME:String		= 'LibAssetSonicClimbBitmap';
		public static const LIB_ASSET_DANCE_ANIM_CLASS_NAME:String		= 'LibAssetSonicDanceBitmap';
		public static const LIB_ASSET_ATTACK_ANIM_CLASS_NAME:String		= 'LibAssetSonicAttackBitmap';
		
		public static const LIB_ASSET_JUMP_SOUND_CLASS_NAME:String			= 'LibAssetSonicJumpSound';
		public static const LIB_ASSET_RING_SPREAD_SOUND_CLASS_NAME:String	= 'LibAssetRingSpreadSound';
		public static const LIB_ASSET_OWWW_SOUND_CLASS_NAME:String			= 'LibAssetSonicOwwwSound';
		public static const LIB_ASSET_SUPER_RUN_SOUND_CLASS_NAME:String		= 'LibAssetSonicBoostSound';
		
		private var ourAnimContainer:Sprite;		
		private var ourFist:IMapAsset;
		private var ourClimbArm:IMapAsset;
		protected var ourRingAssetCache:Array;
		protected var ourMaxRingAssets:uint = 50;
		protected var ourGrindRailCutscene:GrindRailCutScene;
		protected var ourStatUpdateTimer:Timer;
		
		public function Sonic(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0) {
			super(myWorld, myViewport, myX, myY, myRotation);
		}
		
		override protected function init(myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			ourAnimationManager			= new SonicAnimationManager(this);
			ourSoundManager				= new SonicSoundManager(this);
			ourActionFactory			= new SonicActionFactory(this);
			ourRingAssetCache			= new Array(ourMaxRingAssets);
			createRingCache();
			
			var myStatFPS:uint			= 10;
			ourStatUpdateTimer			= new Timer(1000/myStatFPS);
			ourStatUpdateTimer.addEventListener(TimerEvent.TIMER, onStatUpdateTimer);
			ourStatUpdateTimer.start();
			
			/*
			 * Animations
			 */
			ourAnimContainer		= new Sprite();
			ourDisplay.addChild(ourAnimContainer);
			
			var myIdleLeftBitmapClass:Class					= getDefinitionByName(Sonic.LIB_ASSET_IDLE_LEFT_ANIM_CLASS_NAME) as Class;
			var myIdleLeftAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myIdleLeftBitmapClass(360, 120)), 120, 120, 3, 15);
			
			var myIdleRightBitmapClass:Class				= getDefinitionByName(Sonic.LIB_ASSET_IDLE_RIGHT_ANIM_CLASS_NAME) as Class;
			var myIdleRightAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myIdleRightBitmapClass(600, 5880)), 120, 120, 245, 120);
			
			var myIdleAnimationAsset:IAnimationAsset		= new DirectionalSpriteSheetAnimator(myIdleRightAnimationAsset, myIdleLeftAnimationAsset);
			
			ourAnimContainer.addChild((myIdleAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myIdleAnimationAsset, Sonic.ANIMATION_ASSET_IDLE);
						
			var myRunBitmapClass:Class					= getDefinitionByName(Sonic.LIB_ASSET_RUN_ANIM_CLASS_NAME) as Class;
			var myRunAnimationAsset:IAnimationAsset		= new SpriteSheetAnimator(BitmapData(new myRunBitmapClass(600, 2040)), 120, 120, 80, 5);
			ourAnimContainer.addChild((myRunAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myRunAnimationAsset, Sonic.ANIMATION_ASSET_RUN);
			
			var myJumpBitmapClass:Class					= getDefinitionByName(Sonic.LIB_ASSET_JUMP_ANIM_CLASS_NAME) as Class;
			var myJumpAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myJumpBitmapClass(600, 3000)), 120, 120, 120, 160);
			ourAnimContainer.addChild((myJumpAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myJumpAnimationAsset, Sonic.ANIMATION_ASSET_JUMP);
			
			var mySprintBitmapClass:Class				= getDefinitionByName(Sonic.LIB_ASSET_SUPER_RUN_ANIM_CLASS_NAME) as Class;
			var mySprintAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new mySprintBitmapClass(600, 2040)), 120, 120, 80, 160);
			ourAnimContainer.addChild((mySprintAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(mySprintAnimationAsset, Sonic.ANIMATION_ASSET_SUPER_RUN);
			
			var myHitBitmapClass:Class					= getDefinitionByName(Sonic.LIB_ASSET_HIT_ANIM_CLASS_NAME) as Class;
			var myHitAnimationAsset:IAnimationAsset		= new SpriteSheetAnimator(BitmapData(new myHitBitmapClass(600, 720)), 120, 120, 30, 120, false);
			ourAnimContainer.addChild((myHitAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myHitAnimationAsset, Sonic.ANIMATION_ASSET_HIT);
			
			var myDanceBitmapClass:Class					= getDefinitionByName(Sonic.LIB_ASSET_DANCE_ANIM_CLASS_NAME) as Class;
			var myDanceAnimationAsset:IAnimationAsset		= new SpriteSheetAnimator(BitmapData(new myDanceBitmapClass(600, 840)), 120, 120, 35, 30, false);
			ourAnimContainer.addChild((myDanceAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myDanceAnimationAsset, Sonic.ANIMATION_ASSET_DANCE);
			
			
			//make center registered
			ourAnimContainer.x	= Math.round(-(ourAnimContainer.width/2));
			ourAnimContainer.y	= Math.round(-(ourAnimContainer.height/2));
						
			super.init(myX, myY, myRotation);
			
			var myBaseWidth:Number	= ourAnimContainer.width;
			var myBaseHeight:Number = ourAnimContainer.height; 
			
			//adding this after the other stuff that depends on sonic being the right size:
			var myBoostBitmapClass:Class				= getDefinitionByName(Sonic.LIB_ASSET_BOOST_EFFECT_ANIM_CLASS_NAME) as Class;
			var myBoostAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myBoostBitmapClass(980, 166)), 196, 166, 5, 30);
			(myBoostAnimationAsset as IMapAsset).getDisplay().x = (myBaseWidth - (myBoostAnimationAsset as IMapAsset).getDisplay().width)/2;
			(myBoostAnimationAsset as IMapAsset).getDisplay().y = (myBaseHeight - (myBoostAnimationAsset as IMapAsset).getDisplay().height)/2;
			ourAnimContainer.addChild((myBoostAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myBoostAnimationAsset, Sonic.ANIMATION_ASSET_BOOST_EFFECT);
			
			//adding this one after size related stuff too
			//Have to use a directional asset because the horizontal size isn't the same as our hero's body
			var myAttackBitmapClass:Class					= getDefinitionByName(Sonic.LIB_ASSET_ATTACK_ANIM_CLASS_NAME) as Class;
			var myAttackRightAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myAttackBitmapClass(960, 120)), 240, 120, 4, 20, false);
			var myAttackLeftAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myAttackBitmapClass(960, 120)), 240, 120, 4, 20, false);
			myAttackLeftAnimationAsset.faceLeft();
			(myAttackLeftAnimationAsset as IMapAsset).getDisplay().x -= (myAttackLeftAnimationAsset as IMapAsset).getDisplay().width - myBaseWidth;
			var myAttackAnimationAsset:IAnimationAsset		= new DirectionalSpriteSheetAnimator(myAttackRightAnimationAsset, myAttackLeftAnimationAsset);
			ourAnimContainer.addChild((myAttackAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myAttackAnimationAsset, Sonic.ANIMATION_ASSET_ATTACK);
			
			//add after size related
			
			var myClimbBitmapClass:Class				= getDefinitionByName(Sonic.LIB_ASSET_CLIMB_ANIM_CLASS_NAME) as Class;
			var myClimbAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myClimbBitmapClass(720, 240)), 120, 240, 6, 10, false);
			(myClimbAnimationAsset as IMapAsset).getDisplay().y = -(myClimbAnimationAsset as IMapAsset).getDisplay().height/2;
			ourAnimContainer.addChild((myClimbAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myClimbAnimationAsset, Sonic.ANIMATION_ASSET_CLIMB);
			
			//Stop/hide animations			
			ourAnimationAssetManager.stopAndHideAll();
			
			
			//setup defaults
			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.IDLE);			
			ourAnimationManager.addAnimationRequest(myMovementAnimationRequest);
			
			var myFacingAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.FACE_RIGHT);			
			ourAnimationManager.addAnimationRequest(myFacingAnimationRequest);
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= false;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2PolygonDef		= new b2PolygonDef();
			myShapeDef.SetAsOrientedBox(myWorldUnits.getMetersFromPixels(ourDisplay.width*0.65)*0.5, myWorldUnits.getMetersFromPixels(ourDisplay.height * 0.75)*0.5, new b2Vec2(0.0, -myWorldUnits.getMetersFromPixels(ourDisplay.height * 0.25)));
			
			myShapeDef.density				= 1.3;
			myShapeDef.friction				= 0.1;
			myShapeDef.restitution			= 0.0;
			
			var myCircleDef:b2CircleDef		= new b2CircleDef();
			myCircleDef.density				= myShapeDef.density;
			myCircleDef.friction			= myShapeDef.friction;
			myCircleDef.restitution			= myShapeDef.restitution;
			myCircleDef.localPosition		= new b2Vec2(0, myWorldUnits.getMetersFromPixels(ourDisplay.height * 0.25)*0.5);
			myCircleDef.radius				= myWorldUnits.getMetersFromPixels(ourDisplay.width*0.65)*0.5;
			
			/*
			var myCircleDef:b2CircleDef		= new b2CircleDef();
			myCircleDef.radius				= myWorldUnits.getMetersFromPixels(width)*0.5;
			myCircleDef.localPosition		= new b2Vec2(0, .01);
			*/		 
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myShapeDef);
			ourBody.CreateShape(myCircleDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			//ourBody.CreateShape(myCircleDef);
			ourBody.m_flags					|= b2Body.e_fixedRotationFlag;
			
			//Recaclulate Mass after all shapes are added to the Body
			ourBody.SetMassFromShapes();
			
			createFistBody(myWorld, myX, myY, myRotation);
			createClimbArmBody(myWorld, myX, myY, myRotation);
		}
		
		private function createFistBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			var mySonicFist:SonicFist		= new SonicFist(ourActionFactory, myWorld, myX, myY, myRotation);
			mySonicFist.getDispatcher().addEventListener(SonicFistEvent.HIT_ENEMY, onFistHitEnemy);
			ourFist							= mySonicFist;
			
			var myb2World:b2World								= ourBody.m_world;
			var myPrismaticJointDef:b2PrismaticJointDef			= new b2PrismaticJointDef();
			myPrismaticJointDef.Initialize(ourBody, ourFist.getBody(), ourBody.GetPosition(), new b2Vec2(1, 0));
			myPrismaticJointDef.enableLimit						= true;
			myPrismaticJointDef.lowerTranslation				= 0;
			myPrismaticJointDef.upperTranslation				= 0;
			var myPrismaticJoint:b2PrismaticJoint				= myb2World.CreateJoint(myPrismaticJointDef) as b2PrismaticJoint;			
		}
		
		private function createClimbArmBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			var mySonicClimbArm:SonicClimbArm= new SonicClimbArm(ourActionFactory, myWorld, myX, myY, myRotation);
			mySonicClimbArm.getDispatcher().addEventListener(SonicClimbEvent.HIT_PLATFORM, onClimbArmHitPlatform);
			ourClimbArm			= mySonicClimbArm;
			
			var myb2World:b2World								= ourBody.m_world;
			var myPrismaticJointDef:b2PrismaticJointDef			= new b2PrismaticJointDef();
			myPrismaticJointDef.Initialize(ourBody, ourClimbArm.getBody(), ourBody.GetPosition(), new b2Vec2(0, 1));
			myPrismaticJointDef.enableLimit						= true;
			myPrismaticJointDef.lowerTranslation				= 0;
			myPrismaticJointDef.upperTranslation				= 0;
			var myPrismaticJoint:b2PrismaticJoint				= myb2World.CreateJoint(myPrismaticJointDef) as b2PrismaticJoint;
		}
		
		public function collisionOccurred(myCollidable:ICollidable):void {
		}
		
		private function onFistHitEnemy(myEvent:SonicFistEvent):void{
			//Debug.log(this+' knows that his fist hit an enemy');
		}
		
		private function onClimbArmHitPlatform(myEvent:SonicClimbEvent):void{
			//Debug.log(this+' knows that his arm hit a platform');
			var myAnimationManager:IAnimationManager			= getAnimationManager();
			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.CLIMB);
			myAnimationManager.removeAnimationRequest(myMovementAnimationRequest);
			myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
		}
		
		public function attack():void {
			var myPunchDistance:Number				= 1.5;
			var myFacingAnimStack:IStack			= ourAnimationManager.getAnimationStack(PlayerCharacterAnimationStateGroups.FACING_STACK);
			var myCurrentFacing:IAnimationRequest	= myFacingAnimStack.getCurrentItem() as IAnimationRequest;
			var myPos:b2Vec2	= ourBody.GetPosition();
			if(myCurrentFacing.getAnimationName() == PlayerCharacterAnimation.FACE_RIGHT) {			
				myPos.x				+= myPunchDistance;
			}else{
				myPos.x				-= myPunchDistance;
			}
			ourFist.getBody().SetXForm(myPos, 0);
		}
		
		public function extendClimbingArm():void{
			var myClimbDistance:Number				= 2.0;
			var myPos:b2Vec2	= ourBody.GetPosition();
			var myArmPos:b2Vec2	= ourClimbArm.getBody().GetPosition();
			if(Math.abs(Math.abs(myArmPos.y) - Math.abs(myPos.y)) > 0.1)
				return;
			ourClimbArm.getBody().GetShapeList().m_filter.groupIndex = 0;
			myArmPos.y				-= myClimbDistance;
			ourClimbArm.getBody().SetXForm(myArmPos, 0);
			setTimeout(resetClimbArmFilterGroup, 1);
		}
		
		private function resetClimbArmFilterGroup():void{
			ourClimbArm.getBody().GetShapeList().m_filter.groupIndex = -667;
		}
		
		public function getFist():IMapAsset {
			return ourFist;
		}
		
		public function getClimbArm():IMapAsset{
			return ourClimbArm;
		}		
		
		public function getBodies():Array{
			return [
				ourBody,
				ourClimbArm.getBody(),
				ourFist.getBody()
			];
		}

		protected function onStatUpdateTimer(myEvent:TimerEvent):void {
			ourInventory.setSpeed(Math.abs(ourBody.GetLinearVelocity().x));
		}

		protected function createRingCache():void{
			var myRingFactory:IMapAssetFactory			= new SelfDestructingDynamicRingAssetFactory();
			var myRingAsset:IMapAsset;
			var myRingViewport:IMapAssetViewport		= ourWorld.getViewport('ObjectMap1') as IMapAssetViewport;
			
			var myRingDisplay:Sprite					= ourViewport.getDisplay() as Sprite;
			for(var i:uint = 0; i<ourMaxRingAssets; i++){
				myRingAsset	= myRingFactory.createMapAsset(ourWorld, myRingViewport, myRingDisplay, -5, -5);
				ourRingAssetCache[i] = myRingAsset;
				ourCollisionManager.addCollidable(myRingAsset as ICollidable);
			}
		}
		
		public function getMaxRingAssets():uint{
			return ourMaxRingAssets;
		}
		
		public function getRingAssetCache():Array{
			return ourRingAssetCache;
		}
		
		public function getGrindRailCutscene():GrindRailCutScene{
			return ourGrindRailCutscene;
		}
		
		public function setGrindRailCutscene(myCutscene:GrindRailCutScene):void{
			ourGrindRailCutscene = myCutscene;
			ourGrindRailCutscene.setMapAsset(this);
			ourGrindRailCutscene.setInventory(getInventory());
		}
	}
}
