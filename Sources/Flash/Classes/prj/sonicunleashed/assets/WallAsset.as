package prj.sonicunleashed.assets 
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;	

	public class WallAsset extends AbstractMapAsset implements IMapAsset
	{
		public function WallAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number=0, myY:Number=0, myRotation:Number=0) {
			super();
			ourWorld			= myWorld;
			setViewport(myViewport);
			
			createBody(ourWorld, myX, myY, myRotation);
		}
		
		public function createBody(myWorld:IWorld, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void {
			//var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			
			ourBodyDef						= new b2BodyDef();
			ourBodyDef.allowSleep			= true;
			ourBodyDef.isSleeping			= false;
			ourBodyDef.isBullet				= false;//Expensive collision detection mode that makes sure you don't go through other dynamic bodies (only use where necessary on fast and or small moving objects that collide with other moving objects)
			ourBodyDef.userData				= this;
			
			var myWidth:Number				= 0.1;
			var myHeight:Number				= 20;
			var myShapeDef:b2PolygonDef		= new b2PolygonDef();
			myShapeDef.SetAsOrientedBox(myWidth*0.5, myHeight*0.5, new b2Vec2(myWidth*0.5, myHeight*0.5));			
			
			ourBody							= myWorld.createBodyFromMapAsset(this);
			ourBody.CreateShape(myShapeDef);
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
		}
		
		public function destroyBody():void {
		}
	}
}
