package 
{
	import flash.display.SimpleButton;	
	import flash.events.MouseEvent;	
	import flash.net.navigateToURL;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	
	import prj.sonicunleashed.contactfilters.conditions.SonicPassThroughFilterCondition;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;	
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	
	import com.carlcalderon.arthropod.Debug;
	import com.tbg.website.remoting.RemotingFaultEvent;
	import com.tbg.website.remoting.RemotingResponseEvent;
	import com.tbg.website.remoting.Request;
	import com.thebuddygroup.apps.game2d.IAssetLibrary;
	import com.thebuddygroup.apps.game2d.IndexedAssetLibrary;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.connectors.IPersistantActionConnector;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.connectors.KeyToPersistantActionConnector;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.HeroPassThroughFilterCondition;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.IFilterCondition;
	import com.thebuddygroup.apps.game2d.base.mapassets.repeatingbitmap.IRepeatingBitmap;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.ITileMap;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.TileMapData;
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.ITriggerable;
	import com.thebuddygroup.apps.game2d.base.trigger.PostWorldUpdatePersistantTrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.RenderPersistantTrigger;
	import com.thebuddygroup.apps.game2d.base.world.EarthWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.IWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.populators.ArrayWorldPopulator;
	import com.thebuddygroup.apps.game2d.base.world.populators.IWorldPopulator;
	import com.thebuddygroup.apps.game2d.base.world.stats.WorldStatsDisplay;
	import com.thebuddygroup.apps.game2d.base.world.viewport.BitmapTileMapViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.MapAssetToViewportFollowConnector;
	import com.thebuddygroup.apps.game2d.base.world.viewport.MapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.RepeatingBitmapViewport;
	import com.thebuddygroup.apps.tilescrollingengine.BitmapRepeatingScrollTile;
	import com.thebuddygroup.apps.tilescrollingengine.TileMap;
	
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	
	import prj.sonicunleashed.Sonic;
	import prj.sonicunleashed.actions.sonic.SonicActions;
	import prj.sonicunleashed.assets.GrindRailCutScene;
	import prj.sonicunleashed.assets.factories.BoostRampFactory;
	import prj.sonicunleashed.assets.factories.BoostRampThatTriggersGrindCutsceneFactory;
	import prj.sonicunleashed.assets.factories.BumperFactory;
	import prj.sonicunleashed.assets.factories.EvilBallCharacterFactory;
	import prj.sonicunleashed.assets.factories.HorizontalSpikeFactory;
	import prj.sonicunleashed.assets.factories.RingFactory;
	import prj.sonicunleashed.assets.factories.SonicFactory;
	import prj.sonicunleashed.assets.factories.StairsFactory;
	import prj.sonicunleashed.assets.factories.VerticalMovingPlatformFactory;
	import prj.sonicunleashed.assets.factories.VerticalSpikeFactory;
	import prj.sonicunleashed.assets.factories.WallFactory;
	import prj.sonicunleashed.inventory.HeadsUpDisplay;
	import prj.sonicunleashed.remoting.GameServiceAPI;
	import prj.sonicunleashed.sound.audiocontrol.AudioController;
	import prj.sonicunleashed.sound.audiocontrol.MuteControllerMovieClip;		

	public class GameTheoryTest extends Sprite
	{
		public var viewportSize:MovieClip;
		public var fpsMeter:MovieClip;
		public var headsUpDisplay:HeadsUpDisplay;
		public var worldStatsDisplay:WorldStatsDisplay;
		public var slideCutScene:GrindRailCutScene;
		public var mainMenuButton:SimpleButton;
		
		private var ourWorld:IWorld;
		private var ourAssetLibrary:IAssetLibrary;
		private var ourRenderTrigger:ITrigger;
		private var ourBGMusicSound:Sound;
		private var ourBGMusicSoundChannel:SoundChannel;
		
		private var ourBackgroundStaticMappyArray:Array;
		private var ourObjSpawnMap:Array;
		private var ourAudioController:AudioController;
		private var ourGameServiceAPI:GameServiceAPI;
		
		public function GameTheoryTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			loaderInfo.addEventListener(Event.UNLOAD, onUnloaded);
		}
		
		private function onAddedToStage(myEvent:Event):void{
			init();
		}
		
		private function onUnloaded(myEvent:Event):void{
			unInit();
		}
		
		private function unInit():void{
			Debug.log(this+' unInit day game');
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			loaderInfo.removeEventListener(Event.UNLOAD, onUnloaded);			
			stopBGMusic();
		}

		private function init():void{
			stage.align					= StageAlign.TOP_LEFT;
			stage.scaleMode				= StageScaleMode.NO_SCALE;
			
			include "../MappyMaps/dayLevel_450x60.as"
			ourBackgroundStaticMappyArray	= mappyMapLayers['ground_layer_rle'];
			ourObjSpawnMap					= mappyMapLayers['object_layer'];
			
			//var myGatewayURL:String		= loaderInfo.parameters['gatewayURL'] || 'http://dev.sonicunleashed.com/amfphp/gateway.php';
			//ourGameServiceAPI			= new GameServiceAPI(myGatewayURL);
			//testServiceAPI();
			
			mainMenuButton.addEventListener(MouseEvent.CLICK, onClickGotoMainMenu);
			
			ourAudioController			= new AudioController();
			headsUpDisplay.muteSoundIcon.connectToAudioController(ourAudioController);
			
			/*
			 * Music
			 */
			loadBGMusic();
			playBGMusic();
			
			var myWorldFactory:IWorldFactory	= new EarthWorldFactory();			 
			ourWorld							= myWorldFactory.createWorld(new Rectangle(-10, -10, 465, 75));
			ourRenderTrigger					= new RenderPersistantTrigger(ourWorld.getRenderer());
			
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
			
			var myTileMap:ITileMap			= new TileMap();
			myTileMap.initialize(ourWorld, myTileMapViewport, myTileMapData);
			myTileMap.getDisplay().x			= viewportSize.x;
			myTileMap.getDisplay().y			= viewportSize.y;
			ourWorld.addMapAsset(myTileMap);
			myTileMapViewport.setDisplay(myTileMap.getDisplay());
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
			
			var myAssetIndexMap:Object	= new Object();
			myAssetIndexMap['Sonic']	= 1;
			myAssetIndexMap['Ring']		= 2;
			myAssetIndexMap['LeftSpike']= 3;
			myAssetIndexMap['UpSpike']	= 4;
			myAssetIndexMap['Ramp']		= 5;
			myAssetIndexMap['Bumper']	= 6;
			myAssetIndexMap['EnemyObamasaur']	= 7;
			myAssetIndexMap['Stairs']			= 8;
			myAssetIndexMap['MovingPlatform']	= 9;
			myAssetIndexMap['InvisibleWall']	= 10;
			myAssetIndexMap['RampTriggersCutscene']	= 11;
			myAssetIndexMap['EndOfLevel']		= 12;
			myAssetIndexMap['EnemyBigBoss']		= 13;
			
			ourAssetLibrary = new IndexedAssetLibrary();
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['Sonic'], new SonicFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['EnemyObamasaur'], new EvilBallCharacterFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['Ring'], new RingFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['Bumper'], new BumperFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['LeftSpike'], new HorizontalSpikeFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['UpSpike'], new VerticalSpikeFactory());
			//ourAssetLibrary.addAssetFactory(myAssetIndexMap['MovingPlatform'], new VerticalMovingPlatformFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['Ramp'], new BoostRampFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['RampTriggersCutscene'], new BoostRampThatTriggersGrindCutsceneFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['Stairs'], new StairsFactory());
			ourAssetLibrary.addAssetFactory(myAssetIndexMap['InvisibleWall'], new WallFactory());
			
			var myWorldPopulator:IWorldPopulator = new ArrayWorldPopulator(ourObjSpawnMap, 64, 32);
			myWorldPopulator.populate(ourAssetLibrary, ourWorld, myObjectViewport, myObjectDisplay);
			
			
			var myHero:IPlayerCharacter	= ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['Sonic']).getAssets()[0];
			myObjectViewport.setViewportWorldPosition(myHero.getBody().GetPosition().x, myHero.getBody().GetPosition().y);
			
			
			/*
			 * New keyboard connector shit, clean this up!!!
			 */
			myHero.getActionList().setListCyclingTrigger(ourRenderTrigger);			
			
			var myLeftAction:IPersistantAction					= myHero.getActionFactory().getAction(PlayerCharacterActions.MOVE_LEFT_ACTION);
			var myLeftKeyConnector:IPersistantActionConnector	= new KeyToPersistantActionConnector(this.stage, Keyboard.LEFT, myLeftAction);
			myHero.getActionList().addAction(myLeftAction);

			var myRightAction:IPersistantAction					= myHero.getActionFactory().getAction(PlayerCharacterActions.MOVE_RIGHT_ACTION);
			var myRightKeyConnector:IPersistantActionConnector	= new KeyToPersistantActionConnector(this.stage, Keyboard.RIGHT, myRightAction);
			myHero.getActionList().addAction(myRightAction);
			
			var myUpAction:IPersistantAction					= myHero.getActionFactory().getAction(PlayerCharacterActions.JUMP_ACTION);
			var myUpKeyConnector:IPersistantActionConnector		= new KeyToPersistantActionConnector(this.stage, Keyboard.UP, myUpAction);
			myHero.getActionList().addAction(myUpAction);
			
			var mySpacebarAction:IPersistantAction				= myHero.getActionFactory().getAction(SonicActions.SUPER_RUN_ACTION);
			var mySpaceKeyConnector:IPersistantActionConnector	= new KeyToPersistantActionConnector(this.stage, Keyboard.SPACE, mySpacebarAction);
			myHero.getActionList().addAction(mySpacebarAction);
			
			var myControlAction:IPersistantAction				= ActionsFacade.getInstance().addAction(PlayerCharacterActions.ATTACK_ACTION, myHero);
			new KeyToPersistantActionConnector(this.stage, Keyboard.CONTROL, myControlAction);
			
			var myLetterCAction:IPersistantAction				= ActionsFacade.getInstance().addAction(PlayerCharacterActions.CLIMB_ACTION, myHero);
			new KeyToPersistantActionConnector(this.stage, 67, myLetterCAction);
			
			var myLetterDAction:IPersistantAction				= ActionsFacade.getInstance().addAction(PlayerCharacterActions.DANCE_ACTION, myHero);
			new KeyToPersistantActionConnector(this.stage, 68, myLetterDAction);
			
			
			ActionsFacade.getInstance().addActionAndStart(PlayerCharacterActions.MOVE_WATCH_ACTION, myHero);
			
			/*
			 * Evil Ball keyboard controllable
			 */
			
			var myEvilBalls:Array			= ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['EnemyObamasaur']).getAssets();
			for each(var myEvilBall:IPlayerCharacter in myEvilBalls){
				myEvilBall.getActionList().setListCyclingTrigger(ourRenderTrigger);				
			}
			
			var myPlayer2:IPlayerCharacter	= myEvilBalls[0];
			if(myPlayer2){
				myLeftAction					= myPlayer2.getActionFactory().getAction(PlayerCharacterActions.MOVE_LEFT_ACTION);
				myLeftKeyConnector				= new KeyToPersistantActionConnector(this.stage, Keyboard.NUMPAD_4, myLeftAction);
	
				myRightAction					= myPlayer2.getActionFactory().getAction(PlayerCharacterActions.MOVE_RIGHT_ACTION);
				myRightKeyConnector				= new KeyToPersistantActionConnector(this.stage, Keyboard.NUMPAD_6, myRightAction);
				
				myUpAction						= myPlayer2.getActionFactory().getAction(PlayerCharacterActions.JUMP_ACTION);
				myUpKeyConnector				= new KeyToPersistantActionConnector(this.stage, Keyboard.NUMPAD_8, myUpAction);
				
				//ActionsFacade.getInstance().addActionAndStart(PlayerCharacterActions.MOVE_WATCH_ACTION, myPlayer2);
			}
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
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['EnemyObamasaur']).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['Ring']).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['Bumper']).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['LeftSpike']).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['UpSpike']).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['Ramp']).getAssets());
			myHero.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['RampTriggersCutscene']).getAssets());
			
			myHero.getCollisionManager().listenToCollisions(ourWorld.getContactDispatcher());
			
			var myPostWorldStepTrigger:ITrigger	= new PostWorldUpdatePersistantTrigger(ourWorld.getRenderer());
			myPostWorldStepTrigger.connect(myHero.getCollisionManager() as ITriggerable);
			
			//setup hero fist separately
			var myHeroFist:ICollidable	= (myHero as Sonic).getFist() as ICollidable;
			myHeroFist.getCollisionManager().addCollidables(ourAssetLibrary.getAssetFactoryByID(myAssetIndexMap['EnemyObamasaur']).getAssets());
			myHeroFist.getCollisionManager().listenToCollisions(ourWorld.getContactDispatcher());
			myPostWorldStepTrigger.connect(myHeroFist.getCollisionManager() as ITriggerable);
			
			//setup hero climb arm
			var myHeroArm:ICollidable	= (myHero as Sonic).getClimbArm() as ICollidable;
			myHeroArm.getCollisionManager().addCollidable(myTileMap);
			myHeroArm.getCollisionManager().listenToCollisions(ourWorld.getContactDispatcher());
			myPostWorldStepTrigger.connect(myHeroArm.getCollisionManager() as ITriggerable);
			
			/*
			 * Platform contact filter
			 */

			var myShape1:b2Shape	= myHero.getBody().GetShapeList();
			var myShape2:b2Shape	= myTileMap.getBody().GetShapeList();
			var myHeroFilter:IFilterCondition = new HeroPassThroughFilterCondition(myHero);
			ourWorld.getContactFilter().addFilter(myShape1, myShape2, myHeroFilter);
			
//			var myClimbArm:IMapAsset= (myHero as Sonic).getClimbArm();
//			var myClimbArmFilter:IFilterCondition = new HeroPassThroughFilterCondition(myClimbArm);
//			myShape1				= myClimbArm.getBody().GetShapeList(); 
//			ourWorld.getContactFilter().addFilter(myShape1, myShape2, myClimbArmFilter);		
			
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
			addChild(mainMenuButton);
			
			/*
			 * Debug display
			 */			
			var myDebugDrawSprite:Sprite	= new Sprite();
			myDebugDrawSprite.x				= 10;
			myDebugDrawSprite.y				= 420;
			addChildAt(myDebugDrawSprite, 0);
			ourWorld.startDebugDraw(myDebugDrawSprite);
			
			
			(myHero as Sonic).setGrindRailCutscene(slideCutScene);			
		}
		
		private function loadBGMusic():void{
			ourBGMusicSound					= new Sound();
			var context:SoundLoaderContext	= new SoundLoaderContext(2000, true);           
            ourBGMusicSound.load(new URLRequest('audio/day_soundtrack.mp3'), context);
		}
		
		private function playBGMusic():void{
            ourBGMusicSoundChannel = ourBGMusicSound.play();
            ourBGMusicSoundChannel.addEventListener(Event.SOUND_COMPLETE, onBGMusicComplete);
		}
		
		private function stopBGMusic():void {
			ourBGMusicSoundChannel.stop();
		}

		private function onBGMusicComplete(e:Event):void{
			playBGMusic();
		}
		
		private function onClickGotoMainMenu(myEvent:MouseEvent):void{
			navigateToURL(new URLRequest('main_menu.php'), '_self');
		}
		
		/*
		 * Tests for remote service API
		 * TODO: remove this, and setup each api call separately
		 */
	
		
		private function randRange(min:int,max:int):int{
			return Math.floor(Math.random()*(max - min + 1))+min;
		}
		
		private function randChar(minChar:String='A', maxChar:String='Z'):String{
			return String.fromCharCode(randRange(minChar.charCodeAt(0), maxChar.charCodeAt(0)));
		}
	}
}
