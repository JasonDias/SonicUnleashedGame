package prj.sonicunleashed.dialogs 
{
	import com.tbg.dialog.addins.ShowForTimeThenHideDialogAddin;	
	
	import flash.text.TextField;	
	
	import com.tbg.dialog.IDialog;	
	

	public class StatusDialog extends AbstractSonicGameDialog implements IDialog 
	{
		public static const DIALOG_NAME:String = "statusDialog";
		public var statusText:TextField;
		private var ourTimeAddin:ShowForTimeThenHideDialogAddin;
		
		public function StatusDialog()
		{
			this.hide(true);
		}

		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
		
		public function setStatus(myText:String):void
		{
			statusText.text = myText;		
		}
		
		public function showForTime(myMSeconds:Number):void
		{
			if(ourTimeAddin)
				ourTimeAddin.unapply(this);
				
			ourTimeAddin = new ShowForTimeThenHideDialogAddin(myMSeconds, this);
			
			this.show();
		}
		
	}
}
