package prj.sonicunleashed.timer 
{
	import prj.sonicunleashed.timer.format.MinSecMSecTimeFormatter;	
	import prj.sonicunleashed.timer.format.ITimeFormatter;	
	
	import flash.utils.getTimer;	
	

	public class Stopwatch 
	{
		private var ourStartTime:uint;
		private var ourStoppedTime:uint;
		
		private var ourState:String;

		public function Stopwatch()
		{

			ourState = StopwatchStates.TIMER_CLEAR_STATE;
		} 
		
		public function clearTimer():void
		{
			stopTimer();
			setState(StopwatchStates.TIMER_CLEAR_STATE);
		}
		
		public function getTimerState():String
		{
			return ourState;	
		}
		
		public function startTimer():void
		{
			ourStartTime = getTimer();
			setState(StopwatchStates.TIMER_RUNNING_STATE);
		}
		
		private function setState(myState:String):void
		{
			ourState = myState;
		}
		
		public function stopTimer():void
		{
			if(ourState == StopwatchStates.TIMER_CLEAR_STATE || ourState == StopwatchStates.TIMER_STOPPED_STATE)	
				return;
				
			setState(StopwatchStates.TIMER_STOPPED_STATE);
			ourStoppedTime = getTimer(); 
		}
		
		public function getElapsedMSec():uint
		{
			if(ourState == StopwatchStates.TIMER_STOPPED_STATE)
				return ourStoppedTime - ourStartTime;
			
			if(ourState == StopwatchStates.TIMER_RUNNING_STATE)
				return getTimer() - ourStartTime; 
				
			//You haven't started the timer yet..
			return 0;
		}
		
			
	}
}
