package com.thebuddygroup.apps.game2d.base.mapassets.actions {
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IAction;	
	
	import flash.events.IEventDispatcher;	
	

	public interface IPersistantAction extends IAction, IEventDispatcher 
	{
		function stop():void;
		function update():void;
		function setTarget(myTarget:Object):void;
	}
}
