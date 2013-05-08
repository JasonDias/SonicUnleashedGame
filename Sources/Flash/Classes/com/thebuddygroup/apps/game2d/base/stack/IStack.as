package com.thebuddygroup.apps.game2d.base.stack {


	public interface IStack {
		function addItem(myObject:Object):void;
		function removeItem(myObject:Object):void;
		function getCurrentItem():Object;
	}
}
