package prj.sonicunleashed.inventory 
{
	import prj.sonicunleashed.timer.IGameTimer;	
	
	import flash.display.MovieClip;	
	
	import prj.sonicunleashed.sound.audiocontrol.MuteControllerMovieClip;
	
	import com.tbg.util.DateUtil;
	import com.tbg.util.StringUtil;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.AbstractInventoryDisplay;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventoryDisplay;
	
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.getTimer;	


	public class HeadsUpDisplayDay extends AbstractInventoryDisplay implements IInventoryDisplay 
	{
		public var ringsText:TextField;
		public var timeText:TextField;
		public var energyMeter:EnergyMeter;
		public var muteSoundIcon:MuteControllerMovieClip;
		public var promptUserToBoost:MovieClip;
		
		private var ourInitTime:Number;
		private var ourTimer:Timer;
		
		
		function HeadsUpDisplayDay(){
			ourInitTime	= getTimer();
			ourTimer	= new Timer(30);
			ourTimer.addEventListener(TimerEvent.TIMER, onTimer);
			ourTimer.start();
			
			promptUserToBoost.visible = false;
			
			ringsText.text 	= '0';
			energyMeter.setProgress(0);			
		}
		
		private function getGameTimer():IGameTimer
		{
			//Maybe cache this..
			return Application.getMain().getGame().getGameTimer();	
		}
		
		private function onTimer(myEvent:TimerEvent):void{
			timeText.text	= getGameTimer().getElapsedFormatted();
		}
		
		public function updateDisplay(myInventory:IInventory):void
		{
			ringsText.text	= myInventory.getRings().toString();
			energyMeter.setProgress(myInventory.getEnergy());
			promptUserToBoost.visible = (energyMeter.getProgress() >= 0.5);
		}
	}
}
