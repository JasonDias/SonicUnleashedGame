package prj.sonicunleashed.progressbar 
{
	import flash.display.MovieClip;
	
	public class ProgressBar extends MovieClip
	{
		private var ourPercent:Number;
		public var indicator:MovieClip;
		
		public function ProgressBar() {
			setProgressPercent(0);
		}
		
		public function incrementProgress():void{
			if(ourPercent >= 1)
				return;
			ourPercent += 0.01;
			updateDisplay();
		}
		
		public function setProgressPercent(myValue:Number):void{
			if(myValue > 100)
				myValue = 100;
			if(myValue < 0)
				myValue = 0;
			ourPercent 	= myValue/100;
			updateDisplay();
		}
		
		private function updateDisplay():void{
			indicator.scaleX = ourPercent;
		}
	}
}