package prj.sonicunleashed.dialogs 
{
	import prj.sonicunleashed.remoting.GameServiceError;	
	import prj.sonicunleashed.timer.IGameTimer;	
	
	import com.tbg.dialog.Dialog;	
	import com.tbg.dialog.IDialog;	
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.tbg.dialog.DialogEvent;
	import com.tbg.website.remoting.RemotingFaultEvent;
	import com.tbg.website.remoting.RemotingResponseEvent;
	import com.tbg.website.remoting.Request;	
	

	public class EndLevelDialog extends AbstractSonicGameDialog implements IDialog 
	{
		public var nameText:TextField;
	 	public var timeText:TextField;
	 	public var submitButton:MovieClip;
	 	public var statusText:TextField;
	 	
	 	public static const DIALOG_NAME:String = "endLevelDialog";
	 	
		function EndLevelDialog()
		{
			this.hide(true);
			this.addEventListener(DialogEvent.START_SHOW, dialogShown);
			submitButton.addEventListener(MouseEvent.CLICK, clickedSubmitButton);
			nameText.restrict = "A-Z";
		}
		
		private function dialogShown(myEvent:DialogEvent):void
		{
			timeText.text = getGameTimer().getElapsedFormatted();
		}

		private function clickedSubmitButton(myEvent:MouseEvent):void
		{
			if(isNameValid())
			{
				var myListRequest:Request = Application.getMain().getRemotingServiceManager().submitHighScore(nameText.text, getGameTimer().getElapsedMSec() , Application.getMain().getGame().getGameName());
				myListRequest.addEventListener(RemotingResponseEvent.RESULT, gotSubmitScoreResult);
				myListRequest.addEventListener(RemotingFaultEvent.FAULT, gotSubmitScoreFault);
			}
		}
		
		private function isNameValid():Boolean
		{
			if(nameText.text.length < 3)
			{
				showError("name too small. kthxbye.");
				return false;
			}				
			
			if(!(/^[A-Z]{3}$/.test(nameText.text)))
			{
				showError("name got bad stuffz.");
				return false;
			}
			
			return true;
			
		}
		
		
		
		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
		
		public function getGameTimer():IGameTimer
		{
			return Application.getMain().getGame().getGameTimer();
		}
		
		private function gotSubmitScoreFault(myEvent:RemotingFaultEvent):void
		{
			var myError:GameServiceError = GameServiceError.createFromRemotingFaultEvent(myEvent);
			showError(myError.getDescription());
		}

		private function gotSubmitScoreResult(myEvent:RemotingResponseEvent):void
		{
			this.hide();
		}
		
	}
}
