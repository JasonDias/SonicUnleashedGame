package com.thebuddygroup.apps.game2d.base.mapassets.inventory 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.InventoryEvent;	
	
	import flash.events.EventDispatcher;	
	
	import com.carlcalderon.arthropod.Debug;	
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;
	

	public class PlayerCharacterInventory extends EventDispatcher implements IInventory
	{
		protected var ourRings:uint;
		protected var ourEnergy:Number;
		protected var ourSpeed:Number;
		protected var ourLife:Number;
		
		function PlayerCharacterInventory(){
			ourRings	= 0;
			ourEnergy	= 0;
			ourSpeed	= 0;
			ourLife		= 1;
		}
		
		private function dispatchInventoryChange():void{
			dispatchEvent(new InventoryEvent(InventoryEvent.RING_CHANGE));
		}
		
		public function addRing():void
		{
			increaseEnergy();
			ourRings++;
			dispatchInventoryChange();
		}
		
		public function addRings(myRingCount:uint):void
		{
			ourRings += myRingCount;
			dispatchInventoryChange();
		}
		
		public function removeRings(myRingCount:uint):void
		{
			ourRings -= myRingCount;
			dispatchInventoryChange();
		}
		
		public function removeAllRings():void
		{
			ourRings = 0;
			dispatchInventoryChange();
		}
		
		public function removeRing():void
		{
			ourRings--;
			dispatchInventoryChange();
		}
		
		public function getRings():uint
		{
			return ourRings;
		}
		
		public function getEnergy():Number {
			return ourEnergy;
		}
		
		public function increaseEnergy(myPercent:Number=0.04):void {
			ourEnergy += myPercent;
			ourEnergy	= Math.min(1, ourEnergy);
			dispatchInventoryChange();
		}
		
		public function decreaseEnergy(myPercent:Number=0.02):void {
			ourEnergy -= myPercent;
			ourEnergy	= Math.max(0, ourEnergy);
			dispatchInventoryChange();
		}
		
		public function removeAllEnergy():void {
			ourEnergy = 0;
			dispatchInventoryChange();
		}
		
		public function setSpeed(mySpeed:Number):void {
			ourSpeed	= mySpeed;
			dispatchInventoryChange();
		}

		public function getSpeed():Number {
			return ourSpeed;
		}
		
		public function decreaseLife(myAmount:Number = 1):void {
			ourLife -= myAmount;
		}
		
		public function increaseLife(myAmount:Number = 1):void {
			ourLife += myAmount;
		}
		
		public function getLife():Number {
			return ourLife;
		}
		
		public function setLife(myAmount:Number):void {
			ourLife	= myAmount;
		}
	}
}
