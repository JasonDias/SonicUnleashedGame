package prj.sonicunleashed.assets 
{
	import prj.sonicunleashed.sound.RingSoundManager;	
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.MapAssetActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.CollisionManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollisionManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.tilescrollingengine.SpriteSheetAnimator;
	
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2ShapeDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	
	import prj.sonicunleashed.actions.RingActions;
	import prj.sonicunleashed.actions.factories.RingAssetActionFactory;	


	public class RingAsset extends AbstractMapAsset implements IMapAsset, ICollidable
	{
		public static const LIB_ASSET_CLASS_NAME:String				= 'LibAssetRingAnimBitmap';
		public static const LIB_ASSET_RING_SOUND_CLASS_NAME:String	= 'LibAssetRingSound';
		
		protected var ourAnim:SpriteSheetAnimator;
		protected var isMarkedForDelete:Boolean;
		protected var ourCollisionManager:ICollisionManager;
				
		protected var ourFramesPassedSinceCollision:uint = 0;

		public function RingAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0)
		{
			super();
			ourActionFactory	= new RingAssetActionFactory(this as IMapAsset);
			ourSoundManager		= new RingSoundManager(this as IMapAsset);
			ourWorld			= myWorld;
			setViewport(myViewport);
			isMarkedForDelete	= false;
			ourCollisionManager = new CollisionManager(this);
			
			var myRingAssetClass:Class	= getDefinitionByName(RingAsset.LIB_ASSET_CLASS_NAME) as Class;
			ourAnim	= new SpriteSheetAnimator(new myRingAssetClass(480, 120) as BitmapData, 60, 60, 16, 30);
			ourAnim.play();
			ourDisplay.addChild(ourAnim.getDisplay());
			
			createBody(ourWorld, myX, myY, myRotation);
		}
		
		override public function youAreOffTheViewport():void{
			super.youAreOffTheViewport();
			ourAnim.stop();
		}
		
		override public function youAreOnTheViewport(myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			super.youAreOnTheViewport(myX, myY, myRotation);
			ourAnim.play();
		}
		
		protected function deleteSelf():void
		{
			ourFramesPassedSinceCollision++;
			
			if(ourDisplay.parent)
				ourDisplay.parent.removeChild(ourDisplay);
			
			ourBody.PutToSleep();
			
			if(ourBody.m_world.m_lock)
			{
				setTimeout(deleteSelf, 1);
				return;
			}
			ourWorld.destroyBody(ourBody);
			delete this;
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void
		{			
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2CircleDef		= new b2CircleDef();
			myShapeDef.localPosition		= new b2Vec2(myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5, myWorldUnits.getMetersFromPixels(ourDisplay.height)*0.5);
			myShapeDef.radius				= myWorldUnits.getMetersFromPixels(5)*0.5;
			myShapeDef.isSensor				= true;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myShapeDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			
			//Recaclulate Mass after all shapes are added to the Body
			//ourBody.SetMassFromShapes();
		}
		
		public function destroyBody():void
		{
			ourFramesPassedSinceCollision++;
			
			if(ourBody.m_world.m_lock)
			{
				setTimeout(destroyBody, 1);
				return;
			}
			ourWorld.destroyBody(ourBody);
		}
		
		public function collisionOccurred(myCollidable:ICollidable):void
		{
			var myCollidedAsset:IMapAsset = myCollidable as IMapAsset;
			if(!myCollidedAsset)
				return;
			
			if(!ourDisplay.parent)
				return;
			
			ActionsFacade.getInstance().addActionAndStart(RingActions.RING_HIT_ACTION, myCollidedAsset);
			
			getSoundManager().playSound(RingAsset.LIB_ASSET_RING_SOUND_CLASS_NAME);
			
			ourFramesPassedSinceCollision = 0;
			deleteSelf();
		}
		
		public function getCollisionManager():ICollisionManager
		{
			return ourCollisionManager;
		}
	}
}
