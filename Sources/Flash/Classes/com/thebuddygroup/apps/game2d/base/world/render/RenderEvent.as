package com.thebuddygroup.apps.game2d.base.world.render 
{
	import flash.events.Event;	
	

	public class RenderEvent extends Event
	{
		public static const PRE_UPDATE_RENDER:String	= "preUpdateRender";
		public static const POST_UPDATE_RENDER:String	= "postUpdateRender";
		public static const POST_UPDATE_WORLD:String	= 'postUpdateWorld'; 	
		
		public function RenderEvent(myType:String)
		{
			super(myType);	
		}
		
	}
}

