package prj.sonicunleashed.dialogs 
{
	import com.tbg.dialog.DialogEvent;	
	
	import flash.utils.getTimer;	
	import flash.text.TextField;	
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	
	import com.tbg.dialog.addins.IDialogAddin;	
	import com.tbg.dialog.addins.ShowForTimeThenHideDialogAddin;	
	import com.tbg.dialog.IDialog;	
	

	public class GetReadyDialog extends AbstractSonicGameDialog implements IDialog
	{
		public static const DIALOG_NAME:String = "getReadyDialog";
		private var ourMSecondsToCountDown:uint;
		
		private var ourCountDownStartTime:uint;
		private var ourUpdateDisplayTimer:Timer;
		public var countNumbersText:TextField;
		
		public function GetReadyDialog()
		{
			ourUpdateDisplayTimer = new Timer(10);
			ourUpdateDisplayTimer.addEventListener(TimerEvent.TIMER, updateDisplayTimerElapsed);
			this.addEventListener(DialogEvent.DONE_SHOWING, doneShowingSelf);
			this.addEventListener(DialogEvent.START_SHOW, startShowingSelf);
			ourMSecondsToCountDown = 3000;
			clearTimerText();
			this.hide(true);
		}
		
		private function doneShowingSelf(event:DialogEvent):void
		{
			trace('done');
			startCountingDown();
		}

		private function startShowingSelf(event:DialogEvent):void
		{
			trace('start');
			clearTimerText();
		}

		private function updateDisplayTimerElapsed(myEvent:TimerEvent):void
		{
			if(getRemainingTime() < 0)
			{
				getReadyTimerElapsed();
				countNumbersText.text = convertMSecToFormat(0);
				return;
			}
			countNumbersText.text = convertMSecToFormat(getRemainingTime());	
		}


		private function convertMSecToFormat(myMSec:uint):String
		{
			var mySeconds:Number = Math.floor(myMSec/1000);
			var myMSeconds:Number = myMSec - (mySeconds * 1000);
			myMSeconds = Math.floor(myMSeconds / 100);
			return mySeconds.toString() + "." + myMSeconds.toString();
		}
		
		private function clearTimerText():void
		{
			countNumbersText.text = convertMSecToFormat(ourMSecondsToCountDown);
		}

		private function getReadyTimerElapsed():void
		{
			ourUpdateDisplayTimer.stop();
			this.hide();
		}

		private function getRemainingTime():Number
		{
			return ourCountDownStartTime - getTimer();
		}

		public function setMSecondsToCountDown(myMSeconds:uint):void
		{
			ourMSecondsToCountDown = myMSeconds;
			
		}

		public function startCountingDown():void
		{
			ourCountDownStartTime = getTimer() + ourMSecondsToCountDown;
			ourUpdateDisplayTimer.start();
		}
		
		public function getDialogName():String
		{
			return DIALOG_NAME;
		}
	}
}
