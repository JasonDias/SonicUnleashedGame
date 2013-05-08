package com.thebuddygroup.apps.game2d.base 
{
	import com.thebuddygroup.apps.game2d.base.IIdentifier;	
	
	public interface IIdentifiable
	{
		function getIdentifier():IIdentifier;
		function setIdentifier(myIdentifier:IIdentifier):void;
	}
}
