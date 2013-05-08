package com.thebuddygroup.apps.game2d.base.trigger 
{
	import com.adobe.utils.ArrayUtil;	
	

	public class AbstractTrigger 
	{
		private var ourTriggerables:Array;
		
		function AbstractTrigger()
		{ 
			ourTriggerables = new Array();
		}
		
		protected function triggerAll():void
		{
			for each(var myTriggerable:ITriggerable in ourTriggerables){
				myTriggerable.trigger(ITrigger(this));
			}
		}
		
		public function connect(myTriggerable:ITriggerable):void
		{
			ourTriggerables.push(myTriggerable);
		}
		
		public function disconnect(myTriggerable:ITriggerable):void
		{
			ArrayUtil.removeValueFromArray(ourTriggerables, myTriggerable);
		}
	}
}
