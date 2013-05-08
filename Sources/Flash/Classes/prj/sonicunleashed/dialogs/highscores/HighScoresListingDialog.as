package prj.sonicunleashed.dialogs.highscores 
{
	import prj.sonicunleashed.dialogs.AbstractSonicGameDialog;	
	
	import com.tbg.dialog.MovieClipButtonToDialogConnector;	
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import com.tbg.dialog.Dialog;
	import com.tbg.dialog.DialogEvent;
	import com.tbg.dialog.IDialog;
	import com.tbg.gui.layouts.ILayoutter;
	import com.tbg.gui.layouts.LinearLayout;
	import com.tbg.website.remoting.RemotingFaultEvent;
	import com.tbg.website.remoting.RemotingResponseEvent;
	import com.tbg.website.remoting.Request;	


	public class HighScoresListingDialog extends AbstractSonicGameDialog implements IDialog
	{
		private var ourScoreListings:Array;
		private var ourScoresToShow:Number;
		private var ourLayoutter:ILayoutter;
		
		public var startLayoutMarker:MovieClip;
		public var endLayoutMarker:MovieClip;
	 	public var closeButton:MovieClip;
	 	
	 	public static const DIALOG_NAME:String = "highScoresListingDialog";
	 	
		function HighScoresListingDialog()
		{
			this.hide(true);
			ourScoreListings = new Array();	
			ourScoresToShow = 20;
			ourLayoutter = new LinearLayout();
			ourLayoutter.applySetting(LinearLayout.SETTING_START_POINT, new Point(startLayoutMarker.x, startLayoutMarker.y));
			ourLayoutter.applySetting(LinearLayout.SETTING_END_POINT, new Point(endLayoutMarker.x, endLayoutMarker.y));
			this.addEventListener(DialogEvent.START_SHOW, dialogStartShow);
			new MovieClipButtonToDialogConnector(closeButton, this, Dialog.HIDE_ACTION);
		}

		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
		
		private function dialogStartShow(myEvent:DialogEvent):void
		{
			clearAllListingMovieClips();
			showStatus("Loading High Scores...");
			
			var myListRequest:Request = Application.getMain().getRemotingServiceManager().getHighScores(Application.getMain().getGame().getGameName(), ourScoresToShow);
			myListRequest.addEventListener(RemotingResponseEvent.RESULT, gotScoreListingResult);
			myListRequest.addEventListener(RemotingFaultEvent.FAULT, gotScoreListingFault);
		}
		
		private function gotScoreListingFault(myEvent:RemotingFaultEvent):void
		{
			this.showErrorFromEvent(myEvent);
			hideStatus();
		}

		private function gotScoreListingResult(myEvent:RemotingResponseEvent):void
		{
			//var myListingVO:Object;
			var myScoreObjects:Array = myEvent.result;
			var myRank:uint = 1;
			
			for each(var myScoreObject:Object in myScoreObjects)
			{
				var myNewListingMovieClip:ScoreListingMovieClip = new ScoreListingMovieClip();
				this.addChild(myNewListingMovieClip);
				myNewListingMovieClip.setTime( myScoreObject.score );
				myNewListingMovieClip.setName( myScoreObject.name );
				myNewListingMovieClip.setRankNumber( myRank++ );
				ourScoreListings.push(myNewListingMovieClip);
				ourLayoutter.addPlaceable(myNewListingMovieClip);
			}
			
			ourLayoutter.layout();
			hideStatus();
		}
		
		private function clearAllListingMovieClips():void
		{
			for (var i : Number = 0; i < ourScoreListings.length; i++) {
				var myListing:ScoreListingMovieClip = ourScoreListings[i];
				this.removeChild(myListing);
			}			
			ourScoreListings = new Array();
			ourLayoutter.removeAllPlaceables();
		}
		

	}
}
