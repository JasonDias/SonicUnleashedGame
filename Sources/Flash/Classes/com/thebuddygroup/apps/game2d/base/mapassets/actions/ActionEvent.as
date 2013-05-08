package com.thebuddygroup.apps.game2d.base.mapassets.actions {
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IAction;	
	
	import flash.events.Event;	
	
	public class ActionEvent extends Event
	{
		public static const REMOVE_FROM_LIST:String = "removeFromList";
		public static const ADD_TO_LIST:String = "addToList";
		
		function ActionEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		function getAction():IAction
		{
			return this.target as IAction	
		}	
	}
}
