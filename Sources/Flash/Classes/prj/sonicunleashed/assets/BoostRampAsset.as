package prj.sonicunleashed.assets 
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	
	import prj.sonicunleashed.actions.sonic.SonicActions;
	
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
	
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;	

	public class BoostRampAsset extends AbstractMapAsset implements IMapAsset, ICollidable
	{
		public static const LIB_ASSET_CLASS_NAME:String					= 'LibAssetRampBitmap';
		
		private var ourAnim:SpriteSheetAnimator;
		private var ourCollisionManager:ICollisionManager;
		
		public function BoostRampAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0) {
			super();
			ourWorld = myWorld;
			
			var myBumperAssetClass:Class	= getDefinitionByName(BoostRampAsset.LIB_ASSET_CLASS_NAME) as Class;
			ourAnim							= new SpriteSheetAnimator(new myBumperAssetClass(160, 32) as BitmapData, 80, 32, 2, 4);
			ourAnim.playAndShow();
			ourAnim.getDisplay().x			= -ourAnim.getDisplay().width/2;
			ourAnim.getDisplay().y			= -ourAnim.getDisplay().height/2;
			ourDisplay.addChild(ourAnim.getDisplay());
			
			createBody(myWorld, myX, myY, myRotation);
			setViewport(myViewport);
			
			ourCollisionManager = new CollisionManager(this);
		}
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void {
			
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2PolygonDef		= new b2PolygonDef(),
				hx:Number					= myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5,
				hy:Number					= myWorldUnits.getMetersFromPixels(ourDisplay.height)*0.5;
			myShapeDef.vertexCount			= 3;
			myShapeDef.vertices[0].Set(-hx, hy);
			myShapeDef.vertices[1].Set(hx, -hy);
			myShapeDef.vertices[2].Set(hx,  hy);
			//myShapeDef.isSensor				= true;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.SetXForm(new b2Vec2(myX, myY - myWorldUnits.getMetersFromPixels(ourAnim.getDisplay().y)), myRotation);
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
			
			if(!ourDisplay.parent)
				return;
			
			ActionsFacade.getInstance().addActionAndStart(SonicActions.BOOST_RAMP_HIT_ACTION, myCollidedAsset);
		}
		
		public function getCollisionManager():ICollisionManager {
			return ourCollisionManager;
		}
	}
}
