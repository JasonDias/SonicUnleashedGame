package com.thebuddygroup.apps.game2d.base.trigger 
{


	public class AbstractListeningTrigger extends AbstractTrigger
	{
		protected var ourListeningTrigger:ITrigger;
		
		public function setListeningTrigger(myTrigger:ITrigger):void
		{
			ourListeningTrigger = myTrigger;
			ourListeningTrigger.connect(this as ITrigger);
		}
		
	}
}
