package  
{
	import prj.sonicunleashed.dialogs.GameSelectionMenu;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;	

	public class Main extends Sprite
	{
		public var mainMenu:GameSelectionMenu;
		
		public function Main() {
			stage.align					= StageAlign.TOP_LEFT;
			stage.scaleMode				= StageScaleMode.NO_SCALE;
			
			configureMenuButtonListeners(mainMenu.playSonic);
			configureMenuButtonListeners(mainMenu.playWarehog);			
		}
		
		public function loadDayLevel():void{
			navigateToURL(new URLRequest('day_game.php'), '_self');
		}
		
		public function loadNightLevel():void{
			navigateToURL(new URLRequest('night_game.php'), '_self');
		}
		
		private function configureMenuButtonListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(MouseEvent.CLICK, onClickMenuButton);
		}
		
		private function onClickMenuButton(myEvent:MouseEvent):void{
			switch(myEvent.target.name){
				case 'playSonic':
					loadDayLevel();
					break;
				case 'playWarehog':
					loadNightLevel();
					break;
			}
		}		
	}
}
