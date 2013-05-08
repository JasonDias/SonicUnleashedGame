package 
{
	import com.tbg.dialog.IDialog;
	
	import prj.sonicunleashed.dialogs.MainMenuDialog;		

	public class DayMain extends AbstractApplicationMain implements IApplicationMain
	{
		public var highScoresDialog:IDialog;
		public var submitScoreDialog:IDialog;
		public var sendToFriendDialog:IDialog;
		public var errorDialog:IDialog;
		public var mainMenuDialog:IDialog;
		
		function DayMain()
		{			
			//ourDialogManager.getDialog(HighScoresListingDialog.DIALOG_NAME).show();
			//ourDialogManager.getDialog(SubmitScoreDialog.DIALOG_NAME).show();
			//ourDialogManager.getDialog(SendToFriendDialog.DIALOG_NAME).show();
			ourDialogManager.getDialog(MainMenuDialog.DIALOG_NAME).show();
		}
	}
}
