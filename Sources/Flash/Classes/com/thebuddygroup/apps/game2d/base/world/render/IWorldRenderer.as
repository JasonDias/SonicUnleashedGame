package com.thebuddygroup.apps.game2d.base.world.render 
{
	import flash.events.IEventDispatcher;	
	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	

	public interface IWorldRenderer extends IEventDispatcher
	{
		function start():void;
		function stop():void;
	}
}
