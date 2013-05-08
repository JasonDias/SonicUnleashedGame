package prj.sonicunleashed.dialogs.highscores 
{
	import com.tbg.gui.SimplePlaceableMovieClip;	
	import com.tbg.gui.IPlaceable;	
	import com.tbg.util.DateUtil;	
	import com.tbg.util.StringUtil;	
	
	import flash.text.TextField;	
	

	public class ScoreListingMovieClip extends SimplePlaceableMovieClip implements IPlaceable
	{
		public var numberText:TextField;
		public var ordinalSuffixText:TextField;
		public var nameText:TextField;
		public var timeText:TextField;
		
		function ScoreListingMovieClip()
		{
			timeText.embedFonts = true;
		}
		
		public function setRankNumber(myNumber:Number):void
		{
			numberText.text = myNumber.toString();
			ordinalSuffixText.text = StringUtil.getOrdinalSuffix(myNumber);
		}
		
		public function setName(myName:String):void
		{
			nameText.text = myName;
		}
		
		public function setTime(myMilliseconds:uint):void
		{
			//trace(this + " Setting Time: " + myMilliseconds);
			timeText.text = Application.getMain().getGame().getGameTimer().getFormatter().getStringFromMSec(myMilliseconds);
		}
		
		
	}
}
