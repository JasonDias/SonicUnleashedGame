package prj.sonicunleashed.assets 
{
	import prj.sonicunleashed.sound.BumperSoundManager;	
	
	import flash.display.BitmapData;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.getDefinitionByName;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.tilescrollingengine.SpriteSheetAnimator;
	
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	
	import prj.sonicunleashed.actions.sonic.SonicActions;	

	public class BumperAsset extends AbstractMapAsset implements IMapAsset, ICollidable {
		public static const LIB_ASSET_CLASS_NAME:String					= 'LibAssetBumperBitmap';
		public static const LIB_ASSET_SPRING_SOUND_CLASS_NAME:String	= 'LibAssetSpringSound';
		
		private var ourAnim:SpriteSheetAnimator;
		private var isMarkedForDelete:Boolean;
		private var ourCollisionManager:ICollisionManager;		
		
		public function BumperAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0) {
			super();
			
			isMarkedForDelete		= false;
			
			var myBumperAssetClass:Class	= getDefinitionByName(BumperAsset.LIB_ASSET_CLASS_NAME) as Class;
			ourAnim					= new SpriteSheetAnimator(new myBumperAssetClass(420, 64) as BitmapData, 84, 64, 6, 20);
			ourAnim.getDisplay().y	= -20;
			ourAnim.isNonLooping	= true;
			ourAnim.drawFrame(0);
			ourDisplay.addChild(ourAnim.getDisplay());
			ourWorld = myWorld;
			
			createBody(myWorld, myX, myY, myRotation);
			setViewport(myViewport);
			
			ourCollisionManager = new CollisionManager(this);
			ourSoundManager		= new BumperSoundManager(this);
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void {
			
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2CircleDef		= new b2CircleDef();
			myShapeDef.localPosition		= new b2Vec2(myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5, myWorldUnits.getMetersFromPixels(ourDisplay.height)*0.5);
			myShapeDef.radius				= myWorldUnits.getMetersFromPixels(ourDisplay.width*0.4)*0.5;
			myShapeDef.isSensor				= true;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			ourBody.CreateShape(myShapeDef);
			
			//Recaclulate Mass after all shapes are added to the Body
			//ourBody.SetMassFromShapes();
		}
		
		public function destroyBody():void
		{
			ourWorld.destroyBody(ourBody);
		}
				
		public function collisionOccurred(myCollidable:ICollidable):void {
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			if(!ourAnim.isPlaying){
				ActionsFacade.getInstance().addActionAndStart(SonicActions.SUPER_JUMP_ACTION, myCollidedAsset);
				
				ourAnim.play();
				getSoundManager().playSound(BumperAsset.LIB_ASSET_SPRING_SOUND_CLASS_NAME);
			}
		}
		
		public function getCollisionManager():ICollisionManager {
			return ourCollisionManager;
		}
	}
}
