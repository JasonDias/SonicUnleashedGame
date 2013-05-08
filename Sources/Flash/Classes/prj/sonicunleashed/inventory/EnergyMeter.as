package prj.sonicunleashed.inventory 
{
	import flash.display.MovieClip;

	import com.thebuddygroup.progress.IProgressable;	

	public class EnergyMeter extends MovieClip implements IProgressable
	{
		public var energyMask:MovieClip;
		protected var ourProgress:Number;
		
		public function EnergyMeter() {
			setProgress(0);			
		}
		
		private function updateDisplay():void{
			energyMask.gotoAndStop(Math.max(1, Math.min(100, Math.floor(ourProgress * 100)+1)));
		}
		
		public function setProgress(myPercentage:Number):void {
			ourProgress = myPercentage;
			updateDisplay();
		}
		
		public function getProgress():Number {
			return ourProgress;
		}
	}
}
