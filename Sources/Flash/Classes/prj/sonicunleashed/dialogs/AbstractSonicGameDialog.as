package prj.sonicunleashed.dialogs 
{
	import com.tbg.website.remoting.RemotingFaultEvent;	
	
	import prj.sonicunleashed.remoting.GameServiceError;	
	
	import com.tbg.dialog.Dialog;	
	

	public class AbstractSonicGameDialog extends Dialog 
	{
		protected function showError(myErrorMessage:String):void
		{
			ErrorDialog(Application.getMain().getDialogManager().getDialog(ErrorDialog.DIALOG_NAME)).setErrorText(myErrorMessage);
			ErrorDialog(Application.getMain().getDialogManager().getDialog(ErrorDialog.DIALOG_NAME)).show();
		}
		
		protected function showStatus(myStatus:String, myTime:Number = 0):void
		{
			var myDialog:StatusDialog = StatusDialog(Application.getMain().getDialogManager().getDialog(StatusDialog.DIALOG_NAME));
			myDialog.setStatus(myStatus);
			myDialog.show();
			
			if(myTime > 0)
				myDialog.showForTime(myTime);
		}
		
		
		protected function hideStatus():void
		{
			var myDialog:StatusDialog = StatusDialog(Application.getMain().getDialogManager().getDialog(StatusDialog.DIALOG_NAME));
			myDialog.hide();
		}
		
		protected function showErrorFromEvent(myEvent:RemotingFaultEvent):void
		{
			var myError:GameServiceError = GameServiceError.createFromRemotingFaultEvent(myEvent);
			showError(myError.getDescription());	
		}
	}
}
