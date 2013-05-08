package com.thebuddygroup.apps.game2d.base.mapassets.inventory 
{
	import flash.events.Event;
	

	public class InventoryEvent extends Event 
	{
		public static const RING_CHANGE:String	= 'RingChange';
		
		public function InventoryEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
