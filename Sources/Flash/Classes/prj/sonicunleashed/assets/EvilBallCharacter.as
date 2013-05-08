package prj.sonicunleashed.assets 
{
	import prj.sonicunleashed.actions.sonic.SonicActions;	
	
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import prj.sonicunleashed.actions.SpikeActions;
	import prj.sonicunleashed.actions.factories.EvilBallCharacterActionFactory;
	import prj.sonicunleashed.animations.EvilBallCharacterAnimationManager;
	import prj.sonicunleashed.sound.SonicSoundManager;
	
	import com.carlcalderon.arthropod.Debug;
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAssetManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.tilescrollingengine.SpriteSheetAnimator;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;		


	public class EvilBallCharacter extends AbstractPlayerCharacter implements IPlayerCharacter 
	{
		public static const ANIMATION_ASSET_IDLE:String					= 'AnimationAssetIdle';
		public static const ANIMATION_ASSET_RUN:String					= 'AnimationAssetRun';
		public static const ANIMATION_ASSET_JUMP:String					= 'AnimationAssetJump';
		public static const ANIMATION_ASSET_SUPER_RUN:String			= 'AnimationAssetSuperRun';
		public static const ANIMATION_ASSET_BOOST_EFFECT:String			= 'AnimationAssetBoostEffect';
		public static const ANIMATION_ASSET_HIT:String					= 'AnimationAssetHit';
		public static const ANIMATION_ASSET_DANCE:String				= 'AnimationAssetDance';
				
		public static const LIB_ASSET_IDLE_ANIM_CLASS_NAME:String		= 'LibAssetEvilBallIdleBitmap';
		public static const LIB_ASSET_RUN_ANIM_CLASS_NAME:String		= 'LibAssetEvilBallIdleBitmap';
		public static const LIB_ASSET_JUMP_ANIM_CLASS_NAME:String		= 'LibAssetEvilBallIdleBitmap';
		public static const LIB_ASSET_SUPER_RUN_ANIM_CLASS_NAME:String	= 'LibAssetEvilBallIdleBitmap';
		public static const LIB_ASSET_BOOST_EFFECT_ANIM_CLASS_NAME:String= 'LibAssetEvilBallIdleBitmap';
		public static const LIB_ASSET_HIT_ANIM_CLASS_NAME:String		= 'LibAssetEvilBallHitBitmap';
		public static const LIB_ASSET_DANCE_ANIM_CLASS_NAME:String		= 'LibAssetEvilBallIdleBitmap';
		
		public static const LIB_ASSET_JUMP_SOUND_CLASS_NAME:String			= 'LibAssetSonicJumpSound';
		public static const LIB_ASSET_RING_SPREAD_SOUND_CLASS_NAME:String	= 'LibAssetRingSpreadSound';
		public static const LIB_ASSET_OWWW_SOUND_CLASS_NAME:String			= 'LibAssetSonicOwwwSound';
		public static const LIB_ASSET_SUPER_RUN_SOUND_CLASS_NAME:String		= 'LibAssetSonicBoostSound';
		
		private var ourAnimContainer:Sprite;
		
		private var ourAITimer:Timer;
		private var ourLastRunAction:IPersistantAction;
		private var ourLastRunActionName:String;
		private var ourIsMarkedForDelete:Boolean = false;

		public function EvilBallCharacter(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0)
		{
			super(myWorld, myViewport, myX, myY, myRotation);
		}
		
		override protected function init(myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			ourAnimationManager			= new EvilBallCharacterAnimationManager(this);
			ourSoundManager				= new SonicSoundManager(this);
			ourActionFactory			= new EvilBallCharacterActionFactory(this);
			ourAITimer					= new Timer(1500);
			ourAITimer.addEventListener(TimerEvent.TIMER, onAITimer);
			ourAITimer.start();
			
			ourInventory.setLife(5);
			
			//TODO: move these to the factory
			ourActionList.addAction(getActionFactory().getAction(PlayerCharacterActions.MOVE_LEFT_ACTION));
			ourActionList.addAction(getActionFactory().getAction(PlayerCharacterActions.MOVE_RIGHT_ACTION));
			ourActionList.addAction(getActionFactory().getAction(PlayerCharacterActions.JUMP_ACTION));
			
			/*
			 * Animations
			 */
			ourAnimContainer		= new Sprite();
			ourDisplay.addChild(ourAnimContainer);
			
			var myIdleBitmapClass:Class					= getDefinitionByName(EvilBallCharacter.LIB_ASSET_IDLE_ANIM_CLASS_NAME) as Class;
			var myIdleAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myIdleBitmapClass(360, 120)), 120, 120, 6, 10);
			ourAnimContainer.addChild((myIdleAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myIdleAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_IDLE);
						
			var myRunBitmapClass:Class					= getDefinitionByName(EvilBallCharacter.LIB_ASSET_RUN_ANIM_CLASS_NAME) as Class;
			var myRunAnimationAsset:IAnimationAsset		= new SpriteSheetAnimator(BitmapData(new myRunBitmapClass(600, 240)), 120, 120, 10, 60);
			ourAnimContainer.addChild((myRunAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myRunAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_RUN);
			
			var myJumpBitmapClass:Class					= getDefinitionByName(EvilBallCharacter.LIB_ASSET_JUMP_ANIM_CLASS_NAME) as Class;
			var myJumpAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myJumpBitmapClass(600, 240)), 120, 120, 10, 60);
			ourAnimContainer.addChild((myJumpAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myJumpAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_JUMP);
			
			var mySprintBitmapClass:Class				= getDefinitionByName(EvilBallCharacter.LIB_ASSET_SUPER_RUN_ANIM_CLASS_NAME) as Class;
			var mySprintAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new mySprintBitmapClass(600, 240)), 120, 120, 6, 60);
			ourAnimContainer.addChild((mySprintAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(mySprintAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_SUPER_RUN);
			
			var myHitBitmapClass:Class					= getDefinitionByName(EvilBallCharacter.LIB_ASSET_HIT_ANIM_CLASS_NAME) as Class;
			var myHitAnimationAsset:IAnimationAsset		= new SpriteSheetAnimator(BitmapData(new myHitBitmapClass(840, 120)), 120, 120, 7, 10, false);
			ourAnimContainer.addChild((myHitAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myHitAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_HIT);
			
			var myDanceBitmapClass:Class					= getDefinitionByName(EvilBallCharacter.LIB_ASSET_DANCE_ANIM_CLASS_NAME) as Class;
			var myDanceAnimationAsset:IAnimationAsset		= new SpriteSheetAnimator(BitmapData(new myDanceBitmapClass(600, 840)), 120, 120, 35, 30, false);
			ourAnimContainer.addChild((myDanceAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myDanceAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_DANCE);
			
			
			//make center registered
			ourAnimContainer.x	= Math.round(-(ourAnimContainer.width/2));
			ourAnimContainer.y	= Math.round(-(ourAnimContainer.height/2));
						
			super.init(myX, myY, myRotation);
			
			//adding this after the other stuff that depends on sonic being the right size:
			var myBoostBitmapClass:Class				= getDefinitionByName(EvilBallCharacter.LIB_ASSET_BOOST_EFFECT_ANIM_CLASS_NAME) as Class;
			var myBoostAnimationAsset:IAnimationAsset	= new SpriteSheetAnimator(BitmapData(new myBoostBitmapClass(980, 166)), 196, 166, 5, 30);
			(myBoostAnimationAsset as IMapAsset).getDisplay().y = (ourAnimContainer.height - (myBoostAnimationAsset as IMapAsset).getDisplay().height)/2;
			(myBoostAnimationAsset as IMapAsset).getDisplay().x = (ourAnimContainer.width - (myBoostAnimationAsset as IMapAsset).getDisplay().width)/2;
			ourAnimContainer.addChild((myBoostAnimationAsset as IMapAsset).getDisplay());
			ourAnimationAssetManager.addAsset(myBoostAnimationAsset, EvilBallCharacter.ANIMATION_ASSET_BOOST_EFFECT);
			
			ourAnimationAssetManager.stopAndHideAll();
			
			
			//setup defaults
			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.IDLE);			
			ourAnimationManager.addAnimationRequest(myMovementAnimationRequest);
			
			var myFacingAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.FACE_RIGHT);			
			ourAnimationManager.addAnimationRequest(myFacingAnimationRequest);
		}
		
		private function onAITimer(myEvent:TimerEvent):void{
			var myRunActionName:String		= (ourLastRunActionName == PlayerCharacterActions.MOVE_RIGHT_ACTION) ? PlayerCharacterActions.MOVE_LEFT_ACTION:PlayerCharacterActions.MOVE_RIGHT_ACTION;
			var myAction:IPersistantAction	= getActionFactory().getAction(myRunActionName);			
			myAction.start();
			if(ourLastRunAction)
				ourLastRunAction.stop();
			ourLastRunAction				= myAction;
			ourLastRunActionName			= myRunActionName;
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= false;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myCircleDef:b2CircleDef		= new b2CircleDef();
			myCircleDef.density				= 1.3;
			myCircleDef.friction			= 0.1;
			myCircleDef.restitution			= 0.0;
			myCircleDef.radius				= myWorldUnits.getMetersFromPixels(ourDisplay.width*0.7)*0.5;
			myCircleDef.localPosition		= new b2Vec2(0, myWorldUnits.getMetersFromPixels(ourDisplay.width*0.3)*0.5);			
			myCircleDef.filter.groupIndex	= -1;
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myCircleDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			
			ourBody.m_flags					|= b2Body.e_fixedRotationFlag;
			
			//Recaclulate Mass after all shapes are added to the Body
			ourBody.SetMassFromShapes();			
		}
		
		public function collisionOccurred(myCollidable:ICollidable):void {
			if(ourIsMarkedForDelete)
				return;
				
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			//if(ourLastRunAction)
			//	ourLastRunAction.stop();
			//ourAITimer.stop();
			ActionsFacade.getInstance().addActionAndStart(SonicActions.EVIL_BALL_HIT_ACTION, myCollidedAsset);			
		}
		
		override public function youAreOnTheViewport(myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			ourDisplay.visible = true;
			//TODO: Seriously, we need to stop/restart animations here
			//ourAnimationAssetManager.
			//ourAnimationAssetManager.getAsset(EvilBallCharacter.ANIMATION_ASSET_IDLE).playAndShow();
			//ourAITimer.start();
		}
		
		override public function youAreOffTheViewport():void{
			ourDisplay.visible = false;
			//ourAnimationAssetManager.stopAndHideAll();
			//ourAITimer.stop();
		}
		
		public function youGotHit():void{
			if(ourLastRunAction)
				ourLastRunAction.stop();
			ourAITimer.stop();
			
			var myInventory:IInventory	= getInventory();
			//Debug.log(this+' had this much life energy: '+myInventory.getLife());
			myInventory.decreaseLife();
			//Debug.log(this+' now has this much life energy: '+myInventory.getLife());
			
			ourIsMarkedForDelete = true;			
		}
		
		public function youAreDoneFeelingThePain():void{
			if(getInventory().getLife() <= 0){
				youAreDeadGoAwayNow();
			}else{
				ourIsMarkedForDelete = false;
				ourAITimer.start();
			}
		}
		
		private function youAreDeadGoAwayNow():void{			
			if(ourBody.m_world.m_lock)
			{
				setTimeout(youAreDeadGoAwayNow, 1);
				return;
			}
			ourDisplay.visible = false;
			ourAnimationAssetManager.stopAndHideAll();
			
			ourBody.SetLinearVelocity(new b2Vec2(0,0));
			ourBody.SetXForm(new b2Vec2(-5,-5), 0);
			ourBody.m_flags	|= b2Body.e_frozenFlag;
			ourBody.PutToSleep();
			
			if(ourDisplay.parent)
				ourDisplay.parent.removeChild(ourDisplay);
			
			ourWorld.removeMapAsset(this);
			destroyBody();
		}	
	}
}