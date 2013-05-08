package prj.sonicunleashed.dialogs 
{
	import com.tbg.dialog.DialogToDialogConnector;	
	import com.tbg.dialog.DialogEvent;	
	
	import flash.events.MouseEvent;	
	import flash.display.MovieClip;	
	
	import prj.sonicunleashed.dialogs.highscores.HighScoresListingDialog;	
	
	import com.tbg.dialog.MovieClipButtonToDialogConnector;	
	
	import prj.tbg.seatbuddy.tool.tools.ButtonToToolConnector;	
	
	import com.thebuddygroup.gui.MovieClipToPlaceableConnector;	
	import com.tbg.dialog.Dialog;
	import com.tbg.dialog.IDialog;
	
	import prj.sonicunleashed.dialogs.assets.GoldPlateButton;		


	public class MainMenuDialog extends Dialog implements IDialog 
	{
		public var howToPlayButton:GoldPlateButton;
		public var viewHighScoresButton:GoldPlateButton;
		public var sendAPostcardButton:GoldPlateButton;
		public var aboutTheGameButton:GoldPlateButton;
		public var receiveUpdatesButton:GoldPlateButton;
		public var creditsButton:GoldPlateButton;
		public var orderNowButton:GoldPlateButton;
		public var playButton:GoldPlateButton;
		
		public static const DIALOG_NAME:String = "mainMenuDialog";


		//		private var :String;

		public function MainMenuDialog()
		{
			this.hide(true);
			viewHighScoresButton.addEventListener(MouseEvent.CLICK, pressedHighScoresButton);
			sendAPostcardButton.addEventListener(MouseEvent.CLICK, pressedSendAPostcardButton);
			playButton.addEventListener(MouseEvent.CLICK, pressedPlayButton);
			howToPlayButton.addEventListener(MouseEvent.CLICK, pressedHowToPlayButton);
		}
		
		private function pressedHowToPlayButton(event:MouseEvent):void
		{
			var myHTPDialog:IDialog = Application.getMain().getDialogManager().getDialog(HowToPlayDialog.DIALOG_NAME); 
			myHTPDialog.show();
			
			new DialogToDialogConnector(myHTPDialog, DialogEvent.START_HIDE, this, Dialog.SHOW_ACTION, false, true);			
			
			this.hide();	
		}

		private function pressedPlayButton(event:MouseEvent):void
		{
			var myGameDialog:IDialog = Application.getMain().getDialogManager().getDialog(AbstractGame.DIALOG_NAME);
			var myGetReadyDialog:IDialog = Application.getMain().getDialogManager().getDialog(GetReadyDialog.DIALOG_NAME);
			
			new DialogToDialogConnector(myGetReadyDialog, DialogEvent.START_HIDE, myGameDialog, Dialog.SHOW_ACTION, true, true);
			
			myGetReadyDialog.show();
			this.hide();
		}
		

		private function pressedSendAPostcardButton(event:MouseEvent):void
		{
			var mySTFDialog:IDialog = Application.getMain().getDialogManager().getDialog(SendToFriendDialog.DIALOG_NAME); 
			mySTFDialog.show();
			
			new DialogToDialogConnector(mySTFDialog, DialogEvent.START_HIDE, this, Dialog.SHOW_ACTION, false, true);			
			
			this.hide();
			
		}

		private function pressedHighScoresButton(event:MouseEvent):void
		{
			var myHighScoresDialog:IDialog = Application.getMain().getDialogManager().getDialog(HighScoresListingDialog.DIALOG_NAME); 
			myHighScoresDialog.show();
			
			new DialogToDialogConnector(myHighScoresDialog, DialogEvent.START_HIDE, this, Dialog.SHOW_ACTION, false, true);			
			
			this.hide();
		}

		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
		
		
		
	}
}
