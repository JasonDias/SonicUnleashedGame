package com.thebuddygroup.apps.game2d.base.mapassets.inventory 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IHaveLifeEnergy;	
	
	import flash.events.IEventDispatcher;	
	

	public interface IInventory extends IEventDispatcher, IHaveLifeEnergy
	{
		function getRings():uint;
		function addRing():void;
		function addRings(myRingCount:uint):void;
		function removeRing():void;
		function removeRings(myRingCount:uint):void;
		function removeAllRings():void;
		
		function getEnergy():Number;
		function increaseEnergy(myPercent:Number=0.01):void;
		function decreaseEnergy(myPercent:Number=0.01):void;
		function removeAllEnergy():void;
		
		function getSpeed():Number;
		function setSpeed(mySpeed:Number):void;
	}
}
