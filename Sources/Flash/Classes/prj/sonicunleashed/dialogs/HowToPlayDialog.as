package prj.sonicunleashed.dialogs 
{
	import com.tbg.dialog.Dialog;	
	import com.tbg.dialog.IDialog;	
	import com.tbg.dialog.MovieClipButtonToDialogConnector;	
	
	import prj.sonicunleashed.dialogs.assets.GoldPlateButton;	
	

	public class HowToPlayDialog extends AbstractSonicGameDialog implements IDialog
	{
		public static const DIALOG_NAME:String = "howToPlayDialog";
		public var closeButton:GoldPlateButton;
		
		function HowToPlayDialog()
		{
			this.hide(true);	
			new MovieClipButtonToDialogConnector(closeButton, this, Dialog.HIDE_ACTION);
		}
		
		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
	}
}
