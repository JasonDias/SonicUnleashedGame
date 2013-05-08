package com.thebuddygroup.apps.game2d {
	import com.adobe.utils.ArrayUtil;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.IContactFilter;	
	import com.thebuddygroup.apps.game2d.WorldContactFilter;	
	
	import Box2D.Dynamics.b2ContactFilter;	
	
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.IContactListener;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.IWorldFactory;
	import com.thebuddygroup.apps.game2d.base.world.WorldContactListener;
	import com.thebuddygroup.apps.game2d.base.world.render.IWorldRenderer;
	import com.thebuddygroup.apps.game2d.base.world.stats.IWorldStats;
	import com.thebuddygroup.apps.game2d.base.world.stats.WorldStats;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;		

	public class World implements IWorld
	{
		private var ourMapAssets:Array;
		private var ourWorld:b2World;
		private var ourWorldUnits:IWorldUnits;
		private var ourRenderer:IWorldRenderer;
		private var ourTimeStep:Number;
		private var ourIterationsPerStep:uint;
		private var ourContactListener:IContactListener;
		private var ourViewports:Object;
		private var ourStats:IWorldStats;
		private var ourContactFilter:WorldContactFilter;

		public function World(myWorldFactory:IWorldFactory, myb2World:b2World, myWorldUnits:IWorldUnits, myTimeStep:Number=(1.00 / 45.00), myIterationsPerStep:uint=8):void
		{
			if(myWorldFactory == null)
				throw new Error("A World must be created by an IWorldFactory");
				
			ourWorld				= myb2World;
			ourMapAssets			= new Array();
			ourWorldUnits			= myWorldUnits;
			ourTimeStep				= myTimeStep;
			ourIterationsPerStep	= myIterationsPerStep;
			ourViewports			= new Object();
			
			ourStats				= new WorldStats(ourWorld);
			
			ourContactFilter 			= new WorldContactFilter();
			ourWorld.m_contactFilter 	= ourContactFilter;
			
			ourContactListener			= new WorldContactListener();
			ourWorld.m_contactListener	= ourContactListener as b2ContactListener;
		}

		public function startDebugDraw(mySprite:Sprite, myDrawFlags:int=-1):void{
			ourWorld.m_debugDraw				= new b2DebugDraw();
			if(myDrawFlags < 0){
				myDrawFlags						= 0;
				myDrawFlags						|= b2DebugDraw.e_shapeBit;
				myDrawFlags						|= b2DebugDraw.e_jointBit;
			}
			ourWorld.m_debugDraw.m_drawFlags	= myDrawFlags;
			ourWorld.m_debugDraw.m_drawScale	= ourWorldUnits.getPixelsFromMeters(.15);
			ourWorld.m_debugDraw.m_sprite		= mySprite;			
		}

		public function startRendering():void
		{
			ourRenderer.start();				
		}
		
		public function stopRendering():void
		{
			ourRenderer.stop();				
		}

		public function addMapAsset(myMapAsset:IMapAsset):void
		{
			ourMapAssets.push(myMapAsset);			
		}
		
		public function removeMapAsset(myMapAsset:IMapAsset):void
		{
			ArrayUtil.removeValueFromArray(ourMapAssets, myMapAsset);
		}
		
		public function getMapAssets():Array{
			return ourMapAssets;
		}
		
		public function getWorldUnits():IWorldUnits
		{
			return ourWorldUnits;
		}
		
		public function createBodyFromMapAsset(myMapAsset:IMapAsset):b2Body
		{
			return ourWorld.CreateBody(myMapAsset.getBodyDef());
		}
		
		public function step():void
		{
			ourWorld.Step(ourTimeStep, ourIterationsPerStep);
		}
	
		public function getBodyLinkedList():b2Body
		{
			return ourWorld.m_bodyList;
		}
		
		public function getRenderer():IWorldRenderer
		{
			return ourRenderer;
		}
		
		public function getContactDispatcher():IEventDispatcher
		{
			return ourContactListener.getDispatcher();
		}
		
		public function destroyBody(myBody:b2Body):void
		{
			ourWorld.DestroyBody(myBody);
		}
		
		public function addViewport(myName:String, myViewport:IViewport):void
		{
			ourViewports[myName]	= myViewport;
		}
		
		public function getViewport(myName:String):IViewport
		{
			return ourViewports[myName];
		}
		
		public function getStats():IWorldStats
		{
			return ourStats;
		}
		
		public function getContactFilter():IContactFilter
		{
			return ourContactFilter as IContactFilter;
		}
		
		public function setRenderer(myRenderer:IWorldRenderer):void {
			ourRenderer = myRenderer;
		}
	}
}
