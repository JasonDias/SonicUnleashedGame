package com.thebuddygroup.apps.game2d.base.mapassets 
{
	import flash.events.Event;
	
	public class MapAssetEvent extends Event
	{
		public static var UPDATE:String = "update";
		
		function MapAssetEvent(myType:String, myBubbles:Boolean = false, myCancelable:Boolean = false)
		{
			super(myType, myBubbles, myCancelable);		
		}

		public function getMapAsset():IMapAsset
		{
			return IMapAsset(this.target);	
		}
	
	}
}
