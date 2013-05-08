package prj.sonicunleashed.timer.format 
{
	import com.tbg.util.DateUtil;
	import com.tbg.util.StringUtil;	
	

	public class MinSecMSecTimeFormatter implements ITimeFormatter
	{
		public function getStringFromMSec(myMSeconds:uint):String
		{
			var myHotDateTonight:Object = DateUtil.objectFromMilliseconds(myMSeconds);
			
			var myMinutesString:String 			= StringUtil.str_pad(myHotDateTonight.minutes, 2, "0", StringUtil.PAD_LEFT);
			var mySecondsString:String 			= StringUtil.str_pad(myHotDateTonight.seconds, 2, "0", StringUtil.PAD_LEFT);
			var myMillisecondsString:String 	= StringUtil.str_pad( myHotDateTonight.milliseconds, 2, "0", StringUtil.PAD_LEFT).substr(0, 2);
			return myMinutesString + ":" + mySecondsString + "." + myMillisecondsString;
		}
	}
}

