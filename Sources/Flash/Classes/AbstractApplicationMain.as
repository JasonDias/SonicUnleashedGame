package  
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import com.tbg.dialog.DialogManager;
	import com.tbg.dialog.IDialogManager;
	
	import prj.sonicunleashed.remoting.GameServiceAPI;
	import prj.sonicunleashed.remoting.IGameServiceAPI;	

	public class AbstractApplicationMain extends Sprite
	{
		public var gameMain:IGame;
		public var mainMenuButton:SimpleButton;
		
		protected var ourGame:IGame;
		protected var ourGameServiceAPI:IGameServiceAPI;
		protected var ourDialogManager:IDialogManager;

		public function AbstractApplicationMain()
		{
			ourGame				= this.gameMain;			
			ourDialogManager	= new DialogManager();
			Application.setMain(IApplicationMain(this));
			mainMenuButton.addEventListener(MouseEvent.CLICK, onClickGotoMainMenu);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(myEvent:Event):void{
			stage.align					= StageAlign.TOP_LEFT;
			stage.scaleMode				= StageScaleMode.NO_SCALE;
			init();
		}
		
		protected function init():void{
			ourGameServiceAPI	= new GameServiceAPI(stage.loaderInfo.parameters.gatewayURL || 'http://dev.sonicunleashed.com/amfphp/gateway.php');
		}
				
		private function onClickGotoMainMenu(myEvent:MouseEvent):void{
			navigateToURL(new URLRequest('main_menu.php'), '_self');
		}
		
		public function getGame():IGame
		{
			return ourGame;	
		}
		
		public function getDialogManager():IDialogManager
		{
			return ourDialogManager;
		}
		
		public function getRemotingServiceManager():IGameServiceAPI
		{
			return ourGameServiceAPI;
		}
		
		
	}
}
