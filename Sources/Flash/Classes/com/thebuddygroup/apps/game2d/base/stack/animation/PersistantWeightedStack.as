package com.thebuddygroup.apps.game2d.base.stack.animation {
	import com.thebuddygroup.apps.game2d.base.stack.IWeighted;	
	import com.thebuddygroup.apps.game2d.base.stack.IStack;	
	

	public class PersistantWeightedStack implements IStack {
		protected var ourItems:Array;
		
		function PersistantWeightedStack() {
			ourItems	= new Array();
		}

		public function addItem(myObject:Object):void {
			if(!(myObject is IWeighted))
				throw new Error("You tried to add an object to a WeightedStack ("+this+") that is not of type IWeighted. Tsk, tsk.");
				
			ourItems.push(myObject);
		}
		
		public function removeItem(myObject:Object):void {
			var myNumItems:uint = ourItems.length;
			for(var i:uint=0; i<myNumItems; i++){
				var myItem:Object = ourItems[i];
				if(myItem == myObject){
					ourItems.splice(i, 1);
					return;
				}
			}
		}
		
		public function getCurrentItem():Object {
			var myCurrentItem:IWeighted;
			for each(var myItem:IWeighted in ourItems){
				if(!myCurrentItem){
					myCurrentItem = myItem;
					continue;
				}
				if(myItem.getWeight() > myCurrentItem.getWeight()){
					myCurrentItem	= myItem;
				}
			}
			return myCurrentItem;
		}
		
	}
}
