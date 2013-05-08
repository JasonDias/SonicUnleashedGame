package prj.sonicunleashed.assets 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;
	
	import flash.display.MovieClip;
	import flash.events.Event;		

    public class GrindRailCutScene extends MovieClip
	{
		
		private var ourInventory:IInventory;
		private var ourMapAsset:IMapAsset;
		
		public function GrindRailCutScene() {
			stop();
		}
		
		public function setInventory(myInventory:IInventory):void{
			ourInventory	= myInventory;
		}
		
		public function setMapAsset(myMapAsset:IMapAsset):void{
			ourMapAsset		= myMapAsset;
		}
		
		public function getMapAsset():IMapAsset{
			return ourMapAsset;
		}

		public function playFromBeginning():void{
			gotoAndPlay(2);
		}
		
		private function dispatchEndOfVideo():void{
			dispatchEvent(new Event(Event.COMPLETE));
			gotoAndStop(1);
		}
		
		private function dispatchRingEvent():void{
			if(ourInventory){
				ourInventory.addRing();				
			}
		}
	}
}
