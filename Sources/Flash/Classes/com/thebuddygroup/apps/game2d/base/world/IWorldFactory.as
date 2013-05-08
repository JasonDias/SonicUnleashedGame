package com.thebuddygroup.apps.game2d.base.world 
{
	import flash.geom.Rectangle;
	
	import com.thebuddygroup.apps.game2d.base.world.IWorld;		


	public interface IWorldFactory 
	{
		
		function createWorld(myBoundsRectInMeters:Rectangle):IWorld;
	}
}
