package com.thebuddygroup.apps.game2d.base.mapassets.inventory 
{
	import flash.display.MovieClip;
	

	public class AbstractInventoryDisplay extends MovieClip
	{
		
		public function AbstractInventoryDisplay()
		{
		}
		
		public function connectInventory(myInventory:IInventory):void
		{
			myInventory.addEventListener(InventoryEvent.RING_CHANGE, onRingChange);
		}
		
		private function onRingChange(myEvent:InventoryEvent):void
		{
			(this as IInventoryDisplay).updateDisplay(myEvent.target as IInventory);
		}
	}
}
