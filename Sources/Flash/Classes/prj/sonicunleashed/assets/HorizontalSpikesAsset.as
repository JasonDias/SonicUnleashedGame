package prj.sonicunleashed.assets {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;import flash.utils.getDefinitionByName;		


	public class HorizontalSpikesAsset extends AbstractSpikeAsset implements IMapAsset, ICollidable 
	{
		public static const LIB_ASSET_CLASS_NAME:String					= 'LibAssetSpikesHorizontalBitmap';
		
		public function HorizontalSpikesAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0)
		{
			super(myWorld, myViewport, myX, myY, myRotation);			
		}
		
		override protected function init(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			var myAssetClass:Class	= getDefinitionByName(HorizontalSpikesAsset.LIB_ASSET_CLASS_NAME) as Class; 
			var myBitmap:Bitmap		= new Bitmap(new myAssetClass(128, 128) as BitmapData);
			myBitmap.x				= -myBitmap.width/2;
			myBitmap.y				= -myBitmap.height/2;
			ourDisplay.addChild(myBitmap);
			
			super.init(myWorld, myViewport, myX, myY, myRotation);
		}	
		
		public function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void {			
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			myY								-=  myWorldUnits.getMetersFromPixels(26);
			
			var myShapeDef:b2PolygonDef,
				hx:Number					= myWorldUnits.getMetersFromPixels(ourDisplay.width)*0.5,
				hy:Number					= myWorldUnits.getMetersFromPixels(ourDisplay.height)*0.5;
			
			/*
			 * Now we make the solid shape we can stand on w/o hurting ourselves
			 * Leaving out the userData is the key
			 */
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			//ourBodyDef.userData				= this;
			
			myShapeDef						= new b2PolygonDef();
			myShapeDef.vertexCount			= 4;
			myShapeDef.vertices[0].Set(-hx+myWorldUnits.getMetersFromPixels(10), -hy+myWorldUnits.getMetersFromPixels(10));
			myShapeDef.vertices[1].Set(hx, -hy);
			myShapeDef.vertices[2].Set(hx,  hy);
			myShapeDef.vertices[3].Set(-hx+myWorldUnits.getMetersFromPixels(10),  hy-myWorldUnits.getMetersFromPixels(10));
			//myShapeDef.SetAsBox(myWorldUnits.getMetersFromPixels(width)*0.5, myWorldUnits.getMetersFromPixels(height)*0.5);
			//myShapeDef.isSensor				= true;
			
			ourBody = ourSpikeBody			= myWorld.createBodyFromMapAsset(this);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			ourBody.CreateShape(myShapeDef);
			
			/*
			 * Now we make the hit shape
			 * We store this in userData to check for collisions with this small area
			 */
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;			
			
			myShapeDef						= new b2PolygonDef();
			myShapeDef.vertexCount			= 4;
			myShapeDef.vertices[0].Set(-hx+myWorldUnits.getMetersFromPixels(6), -hy+myWorldUnits.getMetersFromPixels(12));
			myShapeDef.vertices[1].Set(-hx+myWorldUnits.getMetersFromPixels(10), -hy+myWorldUnits.getMetersFromPixels(12));
			myShapeDef.vertices[2].Set(-hx+myWorldUnits.getMetersFromPixels(10),  hy-myWorldUnits.getMetersFromPixels(12));
			myShapeDef.vertices[3].Set(-hx+myWorldUnits.getMetersFromPixels(6),  hy-myWorldUnits.getMetersFromPixels(12));
			//myShapeDef.SetAsBox(myWorldUnits.getMetersFromPixels(width)*0.5, myWorldUnits.getMetersFromPixels(height)*0.5);
			myShapeDef.isSensor				= true;
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			ourBody.CreateShape(myShapeDef);
			
			//Recaclulate Mass after all shapes are added to the Body
			//ourBody.SetMassFromShapes();
		}
	}
}
