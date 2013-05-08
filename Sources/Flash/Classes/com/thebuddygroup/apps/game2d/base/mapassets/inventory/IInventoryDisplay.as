package com.thebuddygroup.apps.game2d.base.mapassets.inventory 
{


	public interface IInventoryDisplay 
	{
		function connectInventory(myInventory:IInventory):void;
		function updateDisplay(myInventory:IInventory):void;
	}
}
