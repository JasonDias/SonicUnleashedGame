package com.thebuddygroup.apps.game2d.base.stack.animation {
	import com.adobe.utils.ArrayUtil;	
	import com.thebuddygroup.apps.game2d.base.stack.IStack;
	import com.thebuddygroup.apps.game2d.base.stack.IWeighted;	


	public class PersistantWeightedMultiStack implements IStack {

		protected var ourStacks:Array;
		
		function PersistantWeightedMultiStack(){
			ourStacks	= new Array();
		}

		public function addItem(myObject:Object):void {
			if(!(myObject is IStack))
				throw new Error("You tried to add an object to a WeightedMultiStack ("+this+") that is not of type IStack. Tsk, tsk.");
				
			ourStacks.push(myObject);
		}
		
		public function removeItem(myObject:Object):void {
			ArrayUtil.removeValueFromArray(ourStacks, myObject);
		}
		
		public function getCurrentItem():Object {
			var myCurrentItem:IWeighted;
			var myWeightedItem:IWeighted;
			for each(var myStack:IStack in ourStacks) {
				myWeightedItem		= myStack.getCurrentItem() as IWeighted;
				if(!myCurrentItem){
					myCurrentItem	= myWeightedItem;
					continue;
				}
				if(myWeightedItem.getWeight() > myCurrentItem.getWeight()){
					myCurrentItem	= myWeightedItem;
				}
			}
			return myCurrentItem;
		}
		
	}
}
