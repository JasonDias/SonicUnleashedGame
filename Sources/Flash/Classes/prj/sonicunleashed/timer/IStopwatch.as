package prj.sonicunleashed.timer 
{


	public interface IStopwatch 
	{
		function clearTimer():void;
		function getTimerState():String;
		function startTimer():void;
		function stopTimer():void;
		function getElapsedMSec():uint;
	}
}
