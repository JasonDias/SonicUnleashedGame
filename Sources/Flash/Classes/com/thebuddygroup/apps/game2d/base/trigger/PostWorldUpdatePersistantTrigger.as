package com.thebuddygroup.apps.game2d.base.trigger 
{
	import com.thebuddygroup.apps.game2d.base.trigger.AbstractTrigger;
	import com.thebuddygroup.apps.game2d.base.trigger.ITrigger;
	import com.thebuddygroup.apps.game2d.base.world.render.RenderEvent;
	
	import flash.events.IEventDispatcher;	

	public class PostWorldUpdatePersistantTrigger extends AbstractTrigger implements ITrigger, ITriggerable
	{
		private var ourRenderDispatcher:IEventDispatcher;
		
		function PostWorldUpdatePersistantTrigger(myRenderDispatcher:IEventDispatcher)
		{
			ourRenderDispatcher = myRenderDispatcher;
			
			//This should be ran when the first connect runs, and stopListening when the last item is disconnected.
			startListening();
		}
		
		private function preRendered(myEvent:RenderEvent):void
		{
			this.triggerAll();
		}
		
		private function startListening():void
		{
			ourRenderDispatcher.addEventListener(RenderEvent.POST_UPDATE_WORLD, preRendered);
		}
		
		private function stopListening():void
		{
			ourRenderDispatcher.removeEventListener(RenderEvent.POST_UPDATE_WORLD, preRendered);
		}
		
		public function trigger(myTrigger:ITrigger):void
		{
			triggerAll();
		} 
	}
}
