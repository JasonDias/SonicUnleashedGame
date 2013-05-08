package prj.sonicunleashed.dialogs 
{
	import com.tbg.dialog.MovieClipButtonToDialogConnector;	
	
	import flash.display.MovieClip;	
	import flash.text.TextField;	
	
	import com.tbg.dialog.Dialog;	
	import com.tbg.dialog.IDialog;	
	

	public class ErrorDialog extends Dialog implements IDialog
	{
		public static const DIALOG_NAME:String = "errorDialog";
		public var closeButton:MovieClip;
		public var background:MovieClip;
		public var errorText:TextField;
		
		public function ErrorDialog()
		{
			this.hide(true);
			new MovieClipButtonToDialogConnector(closeButton, this, Dialog.HIDE_ACTION);
			//background.addEventListener(MouseEvent., listener)
		}

		public function setErrorText(myText:String):void
		{
			trace(this + " Setting error text:" + myText);
			errorText.text = myText;	
		}
		
		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
	}
}
