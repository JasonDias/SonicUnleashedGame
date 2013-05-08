package com.thebuddygroup.apps.game2d.base.world 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.IContactFilter;	
	
	import flash.geom.Rectangle;	
	
	import com.thebuddygroup.apps.game2d.base.world.stats.IWorldStats;	
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;	
	
	import flash.events.IEventDispatcher;	
	import flash.events.EventDispatcher;	
	import flash.display.Sprite;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.world.render.IWorldRenderer;
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	
	import Box2D.Dynamics.b2Body;		


	public interface IWorld 
	{
		function addViewport(myName:String, myViewport:IViewport):void;
		function getViewport(myName:String):IViewport;
		function addMapAsset(myMapAsset:IMapAsset):void;
		function removeMapAsset(myMapAsset:IMapAsset):void;
		function getMapAssets():Array;
		function getWorldUnits():IWorldUnits;
		function createBodyFromMapAsset(myMapAsset:IMapAsset):b2Body;
		function destroyBody(myBody:b2Body):void;
		function step():void;
		function startRendering():void;
		function stopRendering():void;
		function getBodyLinkedList():b2Body;
		function setRenderer(myRenderer:IWorldRenderer):void;
		function getRenderer():IWorldRenderer;
		function startDebugDraw(mySprite:Sprite, myDrawFlags:int=-1):void;
		function getContactDispatcher():IEventDispatcher;
		function getStats():IWorldStats;
		function getContactFilter():IContactFilter;
	}
}
