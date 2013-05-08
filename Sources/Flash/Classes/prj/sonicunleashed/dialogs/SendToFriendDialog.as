package prj.sonicunleashed.dialogs 
{
	import prj.sonicunleashed.remoting.GameServiceError;	
	
	import com.tbg.website.remoting.RemotingFaultEvent;	
	import com.tbg.website.remoting.RemotingResponseEvent;	
	import com.tbg.website.remoting.Request;	
	
	import flash.events.MouseEvent;	
	
	import com.tbg.dialog.MovieClipButtonToDialogConnector;	
	
	import flash.display.MovieClip;	
	import flash.text.TextField;	
	
	import com.tbg.dialog.Dialog;	
	import com.tbg.dialog.IDialog;	
	

	public class SendToFriendDialog extends AbstractSonicGameDialog implements IDialog 
	{
		public static const DIALOG_NAME:String = "sendToFriendDialog";
		
		public var yourNameText:TextField;
		public var yourEmailText:TextField;
		public var friendNameText:TextField;
		public var friendEmailText:TextField;
		public var submitButton:MovieClip;
		public var statusText:TextField;
		public var closeButton:MovieClip;

		public function SendToFriendDialog()
		{
			this.hide(true);
			submitButton.buttonMode = true;
			submitButton.addEventListener(MouseEvent.CLICK, clickedSubmitButton);
			new MovieClipButtonToDialogConnector(closeButton, this, Dialog.HIDE_ACTION);	
		}
		
		private function clickedSubmitButton(myEvent:MouseEvent):void
		{
			var mySTFRequest:Request = Application.getMain().getRemotingServiceManager().sendPostCard(yourNameText.text, yourEmailText.text, friendNameText.text, friendEmailText.text);
			
			mySTFRequest.addEventListener(RemotingResponseEvent.RESULT, gotSTFSubmitResult);
			mySTFRequest.addEventListener(RemotingFaultEvent.FAULT, gotSTFSubmitFault);
			showStatus("Sending Postcard...");
		}
		
		private function gotSTFSubmitFault(myEvent:RemotingFaultEvent):void
		{
			showErrorFromEvent(myEvent);
			hideStatus();
		}

		private function gotSTFSubmitResult(myEvent:RemotingResponseEvent):void
		{
			showStatus("Postcard Sent", 3000);
			//this.hide();
		}
		
		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
		
		
	}
}
