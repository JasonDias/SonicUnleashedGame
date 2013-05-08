package com.thebuddygroup.apps.game2d.base.mapassets 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.ISoundManager;	
	
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	import com.thebuddygroup.apps.game2d.base.IIdentifiable;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.IActionList;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;	

	public interface IMapAsset extends IIdentifiable
	{
		function getWorld():IWorld;
		
		function getBody():b2Body;
		function setBody(myb2Body:b2Body):void;
		
		function getBodyDef():b2BodyDef;
		
		function getDisplay():DisplayObjectContainer;
		
		function createBody(myWorld:IWorld, myX:Number=0, myY:Number=0, myRotation:Number=0):void;
		function destroyBody():void;
		
		function setViewport(myViewport:IMapAssetViewport):void;
		function getViewport():IMapAssetViewport;
		
		function update():void;
		
		function getActionFactory():IActionFactory;
		function getActionList():IActionList;
		
		function getAnimationManager():IAnimationManager;
		function getSoundManager():ISoundManager;
		
		function youAreOffTheViewport():void;
		function youAreOnTheViewport(myX:Number=0, myY:Number=0, myRotation:Number=0):void;
		
		function getDispatcher():IEventDispatcher;
	}
}