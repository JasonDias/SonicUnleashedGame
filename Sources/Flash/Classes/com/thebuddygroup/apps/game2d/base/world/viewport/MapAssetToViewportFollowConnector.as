package com.thebuddygroup.apps.game2d.base.world.viewport 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.render.RenderEvent;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;		


	public class MapAssetToViewportFollowConnector 
	{
		private var ourMapAsset:IMapAsset;
		private var ourViewport:IViewport;

		public function MapAssetToViewportFollowConnector(myMapAsset:IMapAsset, myViewport:IViewport)
		{
			ourMapAsset = myMapAsset;
			ourMapAsset.getWorld().getRenderer().addEventListener(RenderEvent.POST_UPDATE_RENDER, mapAssetUpdate);
			ourViewport = myViewport;
		}
		
		private function mapAssetUpdate(event:RenderEvent):void
		{
			//var myWorldUnits:IWorldUnits	= ourMapAsset.getWorld().getWorldUnits();
			var myBody:b2Body				= ourMapAsset.getBody();
			if(!myBody)
				return;
			var myPosition:b2Vec2			= myBody.GetPosition();			
			
			//TODO: make it so the view is centered, except during jump where the character should move up relative to the viewports			
			ourViewport.setViewportWorldPosition(myPosition.x, myPosition.y);			
		}		
	}
}
