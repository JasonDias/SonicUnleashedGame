package com.thebuddygroup.apps.game2d.base.mapassets.actions {
	import flash.events.EventDispatcher;	
	
	public class AbstractPersistantAction extends EventDispatcher
	{
		private var ourTarget:Object;
		
		public function setTarget(myTarget:Object):void
		{
			ourTarget = myTarget;			
		}
		
		protected function dispatchRemoveFromListEvent():void
		{
			this.dispatchEvent(new ActionEvent(ActionEvent.REMOVE_FROM_LIST));
		}

		protected function dispatchAddToListEvent():void
		{
			this.dispatchEvent(new ActionEvent(ActionEvent.ADD_TO_LIST));
		}
		
		protected function getTarget():Object
		{
			if(!ourTarget)
				throw new Error("A PersistantAction (" + this + ") tried to operate on a target that has not been set yet. Tsk, tsk.");
				
			return ourTarget;	
		}
	}
}
