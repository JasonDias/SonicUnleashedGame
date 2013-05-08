package prj.sonicunleashed.timer 
{
	import prj.sonicunleashed.timer.format.MinSecMSecTimeFormatter;	
	import prj.sonicunleashed.timer.format.ITimeFormatter;	
	

	public class SonicGameTimer extends Stopwatch implements IGameTimer
	{
		private var ourFormatter:ITimeFormatter;
		
		public function SonicGameTimer()
		{
			ourFormatter = new MinSecMSecTimeFormatter();
		}
		
		public function getElapsedFormatted():String
		{
			return ourFormatter.getStringFromMSec(getElapsedMSec());	
		}
		
		public function getFormatter():ITimeFormatter
		{
			return ourFormatter;
		}
		
		public function setFormatter(myTimeFormatter:ITimeFormatter):void
		{
			ourFormatter = myTimeFormatter;
		}
	}
}
