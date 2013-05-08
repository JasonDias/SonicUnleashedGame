package prj.sonicunleashed.timer 
{
	import prj.sonicunleashed.timer.format.ITimeFormatter;	
	

	public interface IGameTimer extends IStopwatch
	{
		function getFormatter():ITimeFormatter;
		function getElapsedFormatted():String;
		function setFormatter(myTimeFormatter:ITimeFormatter):void;
	}
}
