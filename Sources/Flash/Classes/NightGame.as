package  
{
	import Box2D.Collision.Shapes.b2Shape;
	
	import prj.sonicunleashed.Sonic;
	import prj.sonicunleashed.actions.sonic.SonicActions;
	import prj.sonicunleashed.assets.factories.BoostRampFactory;
	import prj.sonicunleashed.assets.factories.BoostRampThatTriggersGrindCutsceneFactory;
	import prj.sonicunleashed.assets.factories.BridgeFactory;
	import prj.sonicunleashed.assets.factories.BumperFactory;
	import prj.sonicunleashed.assets.factories.EvilBallCharacterFactory;
	import prj.sonicunleashed.assets.factories.HorizontalSpikeFactory;
	import prj.sonicunleashed.assets.factories.LTowerFactory;
	import prj.sonicunleashed.assets.factories.RailFactory;
	import prj.sonicunleashed.assets.factories.RingFactory;
	import prj.sonicunleashed.assets.factories.SonicFactory;
	import prj.sonicunleashed.assets.factories.StairsFactory;
	import prj.sonicunleashed.assets.factories.TowerFactory;
	import prj.sonicunleashed.assets.factories.VerticalMovingPlatformFactory;
	import prj.sonicunleashed.assets.factories.VerticalSpikeFactory;
	import prj.sonicunleashed.assets.factories.WallFactory;
	import prj.sonicunleashed.assets.factories.WallThatTriggersEndOfLevelFactory;
	
	import com.thebuddygroup.apps.game2d.IndexedAssetLibrary;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.connectors.KeyToPersistantActionConnector;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.HeroPassThroughFilterCondition;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.IFilterCondition;
	import com.thebuddygroup.apps.game2d.base.mapassets.repeatingbitmap.IRepeatingBitmap;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.TileMapData;
	import com.thebuddygroup.apps.game2d.base.trigger.ITriggerable;
	import com.thebuddygroup.apps.game2d.base.trigger.PostWorldUpdatePersistantTrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.RenderPersistantTrigger;
	import com.thebuddygroup.apps.game2d.base.world.EarthWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.IWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.populators.ArrayWorldPopulator;
	import com.thebuddygroup.apps.game2d.base.world.populators.IWorldPopulator;
	import com.thebuddygroup.apps.game2d.base.world.viewport.BitmapTileMapViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.MapAssetToViewportFollowConnector;
	import com.thebuddygroup.apps.game2d.base.world.viewport.MapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.RepeatingBitmapViewport;
	import com.thebuddygroup.apps.tilescrollingengine.BitmapRepeatingScrollTile;
	import com.thebuddygroup.apps.tilescrollingengine.TileMap;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;	

	public class NightGame extends AbstractGame implements IGame
	{
		private static const GAME_NAME:String = 'night';
		
		public function init():void{
			loadMaps();
			
			headsUpDisplay.muteSoundIcon.connectToAudioController(ourAudioController);
			
			/*
			 * Music
			 */
			//IGame(this).loadBGMusic();
			//playBGMusic();
			
			/*
			 * Make a BG repeating layer
			 */
			var myFarBuildingsBitmapClass:Class				= getDefinitionByName('LibAssetBuildingsFarBGBitmap') as Class;
			var myFarBGBMP:BitmapData						= new myFarBuildingsBitmapClass(1728, 600) as BitmapData; 
			var myFarBGViewport:IMapAssetViewport			= new RepeatingBitmapViewport();
			ourWorld.addViewport('HRepeatingBitmap1', myFarBGViewport);
			myFarBGViewport.setViewportPixelBounds(new Rectangle(0, 0, viewportSize.width, viewportSize.height));
			
			var myFarBG:IRepeatingBitmap					= new BitmapRepeatingScrollTile();
			myFarBG.setMovementFactor(0.15, 1);
			myFarBG.initialize(myFarBGBMP, ourWorld, myFarBGViewport);
			myFarBG.getDisplay().x							= viewportSize.x;
			myFarBG.getDisplay().y							= viewportSize.y;
			ourWorld.addMapAsset(myFarBG);
			myFarBGViewport.setDisplay(myFarBG.getDisplay());
			addChild(myFarBGViewport.getDisplay());
			
			/*
			 * Make a BG repeating layer
			 */
			var myBuildingsBitmapClass:Class				= getDefinitionByName('LibAssetBuildingsBGBitmap') as Class;
			var myMidBGBMP:BitmapData						= new myBuildingsBitmapClass(1280, 1000) as BitmapData; 
			var myMidBGViewport:IMapAssetViewport			= new RepeatingBitmapViewport();
			ourWorld.addViewport('HRepeatingBitmap2', myMidBGViewport);
			myMidBGViewport.setViewportPixelBounds(new Rectangle(0, 0, viewportSize.width, viewportSize.height));
			
			var myMidBG:IRepeatingBitmap					= new BitmapRepeatingScrollTile();
			myMidBG.setMovementFactor(0.6, 4);
			myMidBG.initialize(myMidBGBMP, ourWorld, myMidBGViewport);
			myMidBG.getDisplay().x							= viewportSize.x;
			myMidBG.getDisplay().y							= viewportSize.y;
			ourWorld.addMapAsset(myMidBG);
			myMidBGViewport.setDisplay(myMidBG.getDisplay());
			addChild(myMidBGViewport.getDisplay());
			
			/*
			 * Make a BG repeating layer
			 */
			var myTreesBitmapClass:Class					= getDefinitionByName('LibAssetTreesFGBitmap') as Class;
			var myTreesFGBMP:BitmapData						= new myTreesBitmapClass(1230, 600) as BitmapData; 
			var myTreesFGViewport:IMapAssetViewport			= new RepeatingBitmapViewport();
			ourWorld.addViewport('HRepeatingBitmap3', myTreesFGViewport);
			myTreesFGViewport.setViewportPixelBounds(new Rectangle(0, 0, viewportSize.width, viewportSize.height));
			
			var myTreesFG:IRepeatingBitmap					= new BitmapRepeatingScrollTile();
			myTreesFG.setMovementFactor(2, 16);
			myTreesFG.initialize(myTreesFGBMP, ourWorld, myTreesFGViewport);
			myTreesFG.getDisplay().x							= viewportSize.x;
			myTreesFG.getDisplay().y							= viewportSize.y;
			ourWorld.addMapAsset(myTreesFG);
			myTreesFGViewport.setDisplay(myTreesFG.getDisplay());
			
			
			/*
			 * Make a TileMap
			 */			
			var myGoundBitmapClass:Class	= getDefinitionByName('LibAssetGroundBitmap') as Class;
			var myTileBmp:BitmapData		= new myGoundBitmapClass(128, 32) as BitmapData;
			var myTileSize:Rectangle		= new Rectangle(0, 0, 64, 32);
			var myTileBufferAmount:Point	= new Point(0, 0);
			var myTileSpacing:Point			= new Point(0, 0);
			
			var myTileMapViewport:IMapAssetViewport	= new BitmapTileMapViewport();
			ourWorld.addViewport('StaticPlatformTileMap1', myTileMapViewport);
			myTileMapViewport.setViewportPixelBounds(new Rectangle(0, 0, viewportSize.width, viewportSize.height));
			
			var myViewportRect:Rectangle = myTileMapViewport.getViewpotPixelBounds();
			

			var myTileMapData:TileMapData = new TileMapData();
			myTileMapData.initialize(ourBackgroundStaticMappyArray, myTileBmp, myTileSize, myViewportRect, myTileBufferAmount, myTileSpacing);
			
			ourTileMap							= new TileMap();
			ourTileMap.initialize(ourWorld, myTileMapViewport, myTileMapData);
			ourTileMap.getDisplay().x			= viewportSize.x;
			ourTileMap.getDisplay().y			= viewportSize.y;
			ourWorld.addMapAsset(ourTileMap);
			myTileMapViewport.setDisplay(ourTileMap.getDisplay());
			addChild(myTileMapViewport.getDisplay());
	
			
			/*
			 * Make a viewport for our hero
			 */
			var myObjectViewport:IMapAssetViewport = new MapAssetViewport();
			ourWorld.addViewport('ObjectMap1', myObjectViewport);
			myObjectViewport.setViewportPixelBounds(myViewportRect);
			
			var myObjectDisplay:Sprite				= new Sprite();
			myObjectDisplay.x						= viewportSize.x;
			myObjectDisplay.y						= viewportSize.y;			
			myObjectViewport.setDisplay(myObjectDisplay);
			addChild(myObjectViewport.getDisplay());
			
			/*
			 * Make our dynamic objects from the dyn mappy map
			 */
			
			ourAssetIndexMap											= new Dictionary();
			ourAssetIndexMap[SonicFactory]								= {className:SonicFactory, value:1};
			ourAssetIndexMap[RingFactory]								= {className:RingFactory, value:2};
			ourAssetIndexMap[HorizontalSpikeFactory]					= {className:HorizontalSpikeFactory, value:3};
			ourAssetIndexMap[VerticalSpikeFactory]						= {className:VerticalSpikeFactory, value:4};
			ourAssetIndexMap[BoostRampFactory]							= {className:BoostRampFactory, value:5};
			ourAssetIndexMap[BumperFactory]								= {className:BumperFactory, value:6};
			ourAssetIndexMap[EvilBallCharacterFactory]					= {className:EvilBallCharacterFactory, value:7};
			ourAssetIndexMap[StairsFactory]								= {className:StairsFactory, value:8};
			ourAssetIndexMap[VerticalMovingPlatformFactory]				= {className:VerticalMovingPlatformFactory, value:9};
			ourAssetIndexMap[WallFactory]								= {className:WallFactory, value:10};
			ourAssetIndexMap[BoostRampThatTriggersGrindCutsceneFactory]	= {className:BoostRampThatTriggersGrindCutsceneFactory, value:11};
			ourAssetIndexMap[WallThatTriggersEndOfLevelFactory]			= {className:WallThatTriggersEndOfLevelFactory, value:12};
//			ourAssetIndexMap[EnemyBigBossFactory]						= {className:EnemyBigBossFactory, value:13};
			ourAssetIndexMap[TowerFactory]								= {className:TowerFactory, value:14};
			ourAssetIndexMap[LTowerFactory]								= {className:LTowerFactory, value:15};
			ourAssetIndexMap[BridgeFactory]								= {className:BridgeFactory, value:16};
			ourAssetIndexMap[RailFactory]								= {className:RailFactory, value:17};
			
			ourAssetLibrary = new IndexedAssetLibrary();
			
			for each(var myAssetObj:Object in ourAssetIndexMap){
				ourAssetLibrary.addAssetFactory(myAssetObj.value, new myAssetObj.className());
			}			
			
			var myWorldPopulator:IWorldPopulator = new ArrayWorldPopulator(ourObjSpawnMap, 64, 32);
			myWorldPopulator.populate(ourAssetLibrary, ourWorld, myObjectViewport, myObjectDisplay);
			
			
			var myHero:IPlayerCharacter	= ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[SonicFactory].value).getAssets()[0];
			myObjectViewport.setViewportWorldPosition(myHero.getBody().GetPosition().x, myHero.getBody().GetPosition().y);
			
			
			/*
			 * New keyboard connector shit, clean this up!!!
			 */
			myHero.getActionList().setListCyclingTrigger(ourRenderTrigger);			
			
			//We're doing disconnects on these to make the keys disabled by default.
			var myLeftAction:IPersistantAction						= ActionsFacade.getInstance().addAction(PlayerCharacterActions.MOVE_LEFT_ACTION, myHero);
			var myLeftKeyConnector:KeyToPersistantActionConnector	= new KeyToPersistantActionConnector(this.stage, Keyboard.LEFT, myLeftAction);
			//myLeftKeyConnector.disconnect();
			
			var myRightAction:IPersistantAction						= ActionsFacade.getInstance().addAction(PlayerCharacterActions.MOVE_RIGHT_ACTION, myHero);
			var myRightKeyConnector:KeyToPersistantActionConnector	= new KeyToPersistantActionConnector(this.stage, Keyboard.RIGHT, myRightAction);
			//myRightKeyConnector.disconnect();
			
			var myUpAction:IPersistantAction						= ActionsFacade.getInstance().addAction(PlayerCharacterActions.CLIMB_ACTION, myHero);
			var myUpKeyConnector:KeyToPersistantActionConnector		= new KeyToPersistantActionConnector(this.stage, Keyboard.UP, myUpAction);
			//myUpKeyConnector.disconnect();
			
			var myAttackAction:IPersistantAction					= ActionsFacade.getInstance().addAction(PlayerCharacterActions.ATTACK_ACTION, myHero);
			var mySpaceKeyConnector:KeyToPersistantActionConnector	= new KeyToPersistantActionConnector(this.stage, Keyboard.SPACE, myAttackAction);
			//mySpaceKeyConnector.disconnect();
			
			ActionsFacade.getInstance().addActionAndStart(PlayerCharacterActions.MOVE_WATCH_ACTION, myHero);

			/*
			 * Viewport connectors
			 */
			new MapAssetToViewportFollowConnector(myHero, myObjectViewport);
			new MapAssetToViewportFollowConnector(myHero, myTileMapViewport);
			new MapAssetToViewportFollowConnector(myHero, myFarBGViewport);
			new MapAssetToViewportFollowConnector(myHero, myMidBGViewport);
			new MapAssetToViewportFollowConnector(myHero, myTreesFGViewport);
			
			/*
			 * Collilsion listeners
			 */
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[EvilBallCharacterFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[RingFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[BumperFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[HorizontalSpikeFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[VerticalSpikeFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[BoostRampFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[BoostRampThatTriggersGrindCutsceneFactory].value).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[WallThatTriggersEndOfLevelFactory].value).getAssets());
			
			myHero.getCollisionManager().listenToCollisions(ourWorld.getContactDispatcher());
			
			//Setup collisions for fist
			ourPostWorldStepTrigger	= new PostWorldUpdatePersistantTrigger(ourWorld.getRenderer());
			ourPostWorldStepTrigger.connect(myHero.getCollisionManager() as ITriggerable);
			
			var myHeroFist:ICollidable	= (myHero as Sonic).getFist() as ICollidable;
			myHeroFist.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(ourAssetIndexMap[EvilBallCharacterFactory].value).getAssets());
			myHeroFist.getCollisionManager().listenToCollisions(ourWorld.getContactDispatcher());
			ourPostWorldStepTrigger.connect(myHeroFist.getCollisionManager() as ITriggerable);
			
			//setup hero climb arm
			var myHeroArm:ICollidable	= (myHero as Sonic).getClimbArm() as ICollidable;
			myHeroArm.getCollisionManager().addCollidable(ourTileMap);
			myHeroArm.getCollisionManager().listenToCollisions(ourWorld.getContactDispatcher());
			ourPostWorldStepTrigger.connect(myHeroArm.getCollisionManager() as ITriggerable);
			
			/*
			 * Platform passthru contact filter
			 */

			var myShape1:b2Shape	= myHero.getBody().GetShapeList();
			var myShape2:b2Shape	= ourTileMap.getBody().GetShapeList();
			var myHeroFilter:IFilterCondition = new HeroPassThroughFilterCondition(myHero);
			ourWorld.getContactFilter().addFilter(myShape1, myShape2, myHeroFilter);
			
			var myClimbArm:IMapAsset= (myHero as Sonic).getClimbArm();
			var myClimbArmFilter:IFilterCondition = new HeroPassThroughFilterCondition(myClimbArm);
			myShape1				= myClimbArm.getBody().GetShapeList(); 
			ourWorld.getContactFilter().addFilter(myShape1, myShape2, myClimbArmFilter);		
			
			/*
			 * Inventory
			 */
			
			headsUpDisplay.connectInventory(myHero.getInventory());
			
			ourRenderTrigger.connect(ourWorld.getStats());
			worldStatsDisplay.connectStats(ourWorld.getStats());
			
			/*
			 * Make sure certain things are drawn in the right layer order
			 */
			myHero.getViewport().getDisplay().addChild(myHero.getDisplay());			
			addChild(myTreesFGViewport.getDisplay());
			addChild(slideCutScene);
			addChild(headsUpDisplay);
			addChild(worldStatsDisplay);
		}
		
		public function loadBGMusic():void{
			ourBGMusicSound					= new Sound();
			var context:SoundLoaderContext	= new SoundLoaderContext(2000, true);           
            ourBGMusicSound.load(new URLRequest('audio/night_soundtrack.mp3'), context);
		}
		
		public function loadMaps():void
		{			
			include "../MappyMaps/nightLevel_450x60.as"
			
			ourBackgroundStaticMappyArray	= mappyMapLayers['ground_layer_rle'];
			ourObjSpawnMap					= mappyMapLayers['object_layer'];
		}
		
		public function getGameName():String {
			return GAME_NAME;
		}
	}
}
