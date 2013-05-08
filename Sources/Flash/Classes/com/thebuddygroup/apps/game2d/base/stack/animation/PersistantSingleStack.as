package com.thebuddygroup.apps.game2d.base.stack.animation {
	import com.thebuddygroup.apps.game2d.base.stack.IStack;	
	

	public class PersistantSingleStack implements IStack {
		private var ourCurrentItem:Object;
		
		public function addItem(myObject:Object):void {
			ourCurrentItem = myObject;
		}
		
		public function removeItem(myObject:Object):void {
		}
		
		public function getCurrentItem():Object {
			return ourCurrentItem;
		}
	}
}
