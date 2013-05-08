package 
{
	import prj.sonicunleashed.dialogs.MainMenuDialog;
	
	import com.tbg.dialog.IDialog;	

	public class NightMain extends AbstractApplicationMain implements IApplicationMain
	{
		public var highScoresDialog:IDialog;
		public var submitScoreDialog:IDialog;
		public var sendToFriendDialog:IDialog;
		public var errorDialog:IDialog;
		public var mainMenuDialog:IDialog;
		
		function NightMain()
		{			
			//ourDialogManager.getDialog(HighScoresListingDialog.DIALOG_NAME).show();
			//ourDialogManager.getDialog(SubmitScoreDialog.DIALOG_NAME).show();
			//ourDialogManager.getDialog(SendToFriendDialog.DIALOG_NAME).show();
			ourDialogManager.getDialog(MainMenuDialog.DIALOG_NAME).show();
		}
	}
}
