package com.thebuddygroup.apps.game2d.base.world.render 
{
	import Box2D.Common.Math.b2Vec2;	
	
	import com.carlcalderon.arthropod.Debug;	
	
	import flash.events.EventDispatcher;	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	
	import Box2D.Dynamics.b2Body;		


	public class WorldRenderer extends EventDispatcher implements IWorldRenderer
	{
		private var ourTimer:Timer;
		private var ourWorld:IWorld;

		public function WorldRenderer(myWorld:IWorld, myFPS:Number=30.00):void
		{
			ourTimer = new Timer(1000/myFPS);
			ourTimer.addEventListener(TimerEvent.TIMER, render);
			ourWorld = myWorld;
		}

		public function render(event:TimerEvent):void
		{
			dispatchEvent(new RenderEvent(RenderEvent.PRE_UPDATE_RENDER));
			ourWorld.step();
			dispatchEvent(new RenderEvent(RenderEvent.POST_UPDATE_WORLD));
			
			var myMapAssets:Array	= new Array();
			
			var myBody:b2Body = ourWorld.getBodyLinkedList();
			var myMapAsset:IMapAsset;
			
			while(myBody)
			{	
				myMapAsset = myBody.m_userData as IMapAsset;
				
				if(myMapAsset != null)
				{
					myMapAssets.push(myMapAsset);
				}
				
				myBody = myBody.m_next;
			}
			
			for each(myMapAsset in myMapAssets){
				myMapAsset.update();
			}
			
			dispatchEvent(new RenderEvent(RenderEvent.POST_UPDATE_RENDER));
		}
		
		public function start():void
		{
			ourTimer.start();
		}

		public function stop():void
		{
			ourTimer.stop();
		}
	}
}
