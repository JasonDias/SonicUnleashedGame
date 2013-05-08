package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	
	import com.tbg.dialog.Dialog;
	import com.tbg.dialog.DialogEvent;
	import com.tbg.dialog.DialogToDialogConnector;
	import com.tbg.dialog.IDialog;
	import com.thebuddygroup.apps.game2d.IAssetLibrary;
	import com.thebuddygroup.apps.game2d.base.mapassets.tilemap.ITileMap;
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.RenderPersistantTrigger;
	import com.thebuddygroup.apps.game2d.base.world.EarthWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.IWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.stats.WorldStatsDisplay;
	
	import prj.sonicunleashed.assets.GrindRailCutScene;
	import prj.sonicunleashed.dialogs.EndLevelDialog;
	import prj.sonicunleashed.dialogs.MainMenuDialog;
	import prj.sonicunleashed.dialogs.highscores.HighScoresListingDialog;
	import prj.sonicunleashed.inventory.HeadsUpDisplayDay;
	import prj.sonicunleashed.sound.audiocontrol.AudioController;
	import prj.sonicunleashed.timer.IGameTimer;
	import prj.sonicunleashed.timer.SonicGameTimer;		

	public class AbstractGame extends Dialog implements IDialog
	{
		public var viewportSize:MovieClip;
		public var fpsMeter:MovieClip;
		public var headsUpDisplay:HeadsUpDisplayDay;
		public var worldStatsDisplay:WorldStatsDisplay;
		public var slideCutScene:GrindRailCutScene;
		
		protected var ourAudioController:AudioController;
		
		protected var ourWorld:IWorld;
		protected var ourAssetIndexMap:Dictionary;
		protected var ourAssetLibrary:IAssetLibrary;
		protected var ourRenderTrigger:ITrigger;
		protected var ourBGMusicSound:Sound;
		protected var ourBGMusicSoundChannel:SoundChannel;
		protected var ourTileMap:ITileMap;
		protected var ourPostWorldStepTrigger:ITrigger;
		
		protected var ourBackgroundStaticMappyArray:Array;
		protected var ourObjSpawnMap:Array;
		protected var ourGameTimer:IGameTimer;
		
		//protected var ourKeyConnectors:Array;
		
		
		public static const DIALOG_NAME:String = "gameDialog";
		
		public function AbstractGame()
		{
			ourAudioController					= new AudioController();
			ourGameTimer						= new SonicGameTimer();
			var myWorldFactory:IWorldFactory	= new EarthWorldFactory();			 
			ourWorld							= myWorldFactory.createWorld(new Rectangle(-10, -10, 465, 75));
			ourRenderTrigger					= new RenderPersistantTrigger(ourWorld.getRenderer());
			
			hide(true);
			
			addEventListener(DialogEvent.START_SHOW, selfDoneShowing);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//HOOK IT UP TO DONE_SHOWING EVENT!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//startGame();
		}
		
		private function selfDoneShowing(event:DialogEvent):void
		{
			trace(this + " Done showing.. Start game.");
			startGame();
		}

		private function startGame():void
		{
			ourWorld.startRendering();
			ourGameTimer.startTimer();
		}
		
		private function stopGame():void
		{
			ourWorld.stopRendering();
			ourGameTimer.stopTimer();
			
		}
		
		public function endOfLevelReached():void
		{
			stopGame();

			var myHighScoresDialog:IDialog = Application.getMain().getDialogManager().getDialog(HighScoresListingDialog.DIALOG_NAME);
			var myEndOfGameDialog:IDialog = Application.getMain().getDialogManager().getDialog(EndLevelDialog.DIALOG_NAME);
			//var myMainMenuDialog:IDialog = Application.getMain().getDialogManager().getDialog(MainMenuDialog.DIALOG_NAME);
			
			new DialogToDialogConnector(myEndOfGameDialog, DialogEvent.START_HIDE, myHighScoresDialog, Dialog.SHOW_ACTION, false, true);
			
			//new DialogToDialogConnector(myHighScoresDialog, DialogEvent.START_HIDE, myMainMenuDialog, Dialog.SHOW_ACTION, false, true);
			
			//This may be replaced by a non-refreshing version of this..
			myHighScoresDialog.addEventListener(DialogEvent.START_HIDE, restartApplication);
			
			myEndOfGameDialog.show();
		}
		
		private function restartApplication(myEvent:DialogEvent):void
		{
			ExternalInterface.call("self.location.reload()");
		}

		protected function onAddedToStage(myEvent:Event):void{
			stage.align					= StageAlign.TOP_LEFT;
			stage.scaleMode				= StageScaleMode.NO_SCALE;
			
			IGame(this).init();
		
			
			/*
			 * Debug display
			 */			
			var myDebugDrawSprite:Sprite	= new Sprite();
			myDebugDrawSprite.x				= 10;
			myDebugDrawSprite.y				= 420;
			addChildAt(myDebugDrawSprite, 0);
			ourWorld.startDebugDraw(myDebugDrawSprite);
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
		
		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
		
		public function getGameTimer():IGameTimer
		{
			return ourGameTimer;	
		}
	}
}
