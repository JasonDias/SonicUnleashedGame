package prj.sonicunleashed.assets 
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;	


	public class TowerAsset extends AbstractMapAsset implements IMapAsset 
	{
		public static const TOWER_BITMAP_CLASS_NAME:String	= 'LibAssetTowerBitmap';
		
		private var ourBitmap:Bitmap;
		
		public function TowerAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0) {
			super();
			ourWorld = myWorld;
			
			var myBitmapClass:Class			= getDefinitionByName(TOWER_BITMAP_CLASS_NAME) as Class; 
			var myBMPData:BitmapData		= new myBitmapClass(128, 384) as BitmapData;
			ourBitmap						= new Bitmap(myBMPData);
			ourBitmap.x						= - ourBitmap.width/2;
			ourBitmap.y						= - (ourBitmap.height+64)/2;
			ourDisplay.addChild(ourBitmap);
			
			createBody(myWorld, myX, myY, myRotation);
			setViewport(myViewport);			
		}
		
		public function createBody(myWorld:IWorld, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void {
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myShapeDef:b2PolygonDef		= new b2PolygonDef(),
				hx:Number					= myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5,
				hy:Number					= myWorldUnits.getMetersFromPixels(ourDisplay.height - 64)*0.5;
			myShapeDef.vertexCount			= 4;
			myShapeDef.vertices[0].Set(-hx, hy);
			myShapeDef.vertices[1].Set(-hx, -hy);
			myShapeDef.vertices[2].Set(hx, -hy);
			myShapeDef.vertices[3].Set(hx,  hy);
			//myShapeDef.isSensor				= true;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.SetXForm(new b2Vec2(myX + hx, myY - hy + myWorldUnits.getMetersFromPixels(32+8)), myRotation);
			ourBody.CreateShape(myShapeDef);
			
			//Recaclulate Mass after all shapes are added to the Body
			//ourBody.SetMassFromShapes();
		}
		
		public function destroyBody():void {
			ourWorld.destroyBody(ourBody);
		}		
	}
}
