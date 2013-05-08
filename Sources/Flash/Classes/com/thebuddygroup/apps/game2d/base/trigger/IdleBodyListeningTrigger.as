package com.thebuddygroup.apps.game2d.base.trigger 
{
	import Box2D.Dynamics.b2Body;	
	
	

	public class IdleBodyListeningTrigger extends AbstractListeningTrigger implements IListeningTrigger 
	{
		private var ourBody:b2Body;
		
		public function IdleBodyListeningTrigger(myBody:b2Body)
		{
			ourBody	= myBody;
		}
		
		public function trigger(myTrigger:ITrigger):void
		{
			if(Math.abs(ourBody.GetLinearVelocity().x) == 0 && Math.abs(ourBody.GetLinearVelocity().y) == 0)
				triggerAll();
		}
	}
}
