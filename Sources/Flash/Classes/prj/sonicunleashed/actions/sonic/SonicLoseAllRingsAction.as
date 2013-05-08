package prj.sonicunleashed.actions.sonic 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.Sonic;
	import prj.sonicunleashed.assets.SelfDestructingDynamicRingAsset;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	
	import flash.utils.setTimeout;		


	public class SonicLoseAllRingsAction extends AbstractPersistantAction implements IPersistantAction {
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myHero:Sonic			= getTarget() as Sonic;
			var myInventory:IInventory	= myHero.getInventory();
			myInventory.removeAllEnergy();			
			if(myInventory.getRings() > 0){
				//delayed since we deal with modifying body position/velocity etc...
				//during a collision callback
				//setTimeout(spawnRingsFromSonic, 1);
				spawnRingsFromSonic();
			}
		}
		
		private function spawnRingsFromSonic():void{			
			var myHero:Sonic				= getTarget() as Sonic;
			var myWorld:IWorld				= myHero.getWorld();
			var myViewport:IViewport		= myWorld.getViewport('ObjectMap1');
			//var myDisplay:Sprite			= myViewport.getDisplay() as Sprite;
			//var myCollisionManager:ICollisionManager	= myHero.getCollisionManager();
			var myWorldUnits:IWorldUnits	= myWorld.getWorldUnits();
			var myBody:b2Body				= myHero.getBody();
			var myPosition:b2Vec2			= myBody.GetPosition();
			
			var myRingCount:uint			= Math.min(myHero.getMaxRingAssets(), myHero.getInventory().getRings());
			//var myMapAssetFactory:IMapAssetFactory = new SelfDestructingDynamicRingAssetFactory();			
			var myRingAsset:IMapAsset;
			var myRingBody:b2Body;
			
			var myRingCache:Array			= myHero.getRingAssetCache();
			
			var myRadius:Number				= myWorldUnits.getMetersFromPixels((Math.max(myHero.getDisplay().width, myHero.getDisplay().height)+100));
			var myRingsPerRadius:uint		= 10;
			var myRadiusIncrement:Number	= myWorldUnits.getMetersFromPixels(60); 
			var mySpeed:Number				= 15;
			var myRad:Number;
			var mySinRad:Number;
			var myCosRad:Number;
			var myX:Number			= myPosition.x;
			var myY:Number			= myPosition.y;
			var myVelocity:b2Vec2	= new b2Vec2();
			for(var i:uint=0, j:uint=1; i < myRingCount; i++, j++){
				if(i % myRingsPerRadius == 0){
					myRadius		+= myRadiusIncrement;
					j				= 1;
				} 
				
				myRad				= (j/myRingsPerRadius * Math.PI) - Math.PI;
				mySinRad			= Math.sin(myRad);
				myCosRad			= Math.cos(myRad);
				myX					= myPosition.x + myCosRad * myRadius;
				myY					= myPosition.y + mySinRad * myRadius;
				myVelocity.x		= myCosRad * mySpeed;
				myVelocity.y		= mySinRad * mySpeed;
				//myRingAsset			= myMapAssetFactory.createMapAsset(myWorld, myViewport, myDisplay, myX, myY, 0);
				myRingAsset			= myRingCache[i];
				
				if(!myRingAsset)
					continue;
				
				(myRingAsset as SelfDestructingDynamicRingAsset).showThenSelfDestruct(myX, myY, 0, myVelocity);
				//myRingBody			= myRingAsset.getBody();
//				if(myRingBody)			
//					myRingBody.SetLinearVelocity(myVelocity);
				
				//myCollisionManager.addCollidable(myRingAsset as ICollidable);
				//myWorld.addMapAsset(myRingAsset);
            	//myRingAsset.update();        
            	//myDisplay.addChild(myRingAsset as Sprite);
			}
			myHero.getSoundManager().playSound(Sonic.LIB_ASSET_RING_SPREAD_SOUND_CLASS_NAME);			
			myHero.getInventory().removeAllRings();
		}
	}
}
