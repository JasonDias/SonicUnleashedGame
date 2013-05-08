package com.thebuddygroup.apps.game2d.base.trigger 
{
	import Box2D.Dynamics.b2Body;		


	public class MovingUpListeningTrigger extends AbstractListeningTrigger implements IListeningTrigger 
	{		
		private var ourBody:b2Body;
		
		public function MovingUpListeningTrigger(myBody:b2Body)
		{
			ourBody	= myBody;
		}
		
		public function trigger(myTrigger:ITrigger):void
		{
			if(ourBody.GetLinearVelocity().y < 0)
				triggerAll();
		}		
	}
}
