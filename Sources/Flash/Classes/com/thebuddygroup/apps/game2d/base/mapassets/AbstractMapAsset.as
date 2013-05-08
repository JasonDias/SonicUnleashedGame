package com.thebuddygroup.apps.game2d.base.mapassets 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	
	import com.thebuddygroup.apps.game2d.base.IIdentifier;
	import com.thebuddygroup.apps.game2d.base.identifiers.NumericIdentifier;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.CyclingActionList;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.list.IActionList;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.EmptyAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.ISoundManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.SoundManager;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;		

	public class AbstractMapAsset
	{
		protected var ourDispatcher:IEventDispatcher;
		protected var ourBody:b2Body;
		protected var ourBodyDef:b2BodyDef;
		protected var ourWorld:IWorld;
		protected var ourViewport:IMapAssetViewport;
		protected var ourDisplay:DisplayObjectContainer;
		protected var ourIdentifier:IIdentifier;
		protected var ourAnimationManager:IAnimationManager;
		protected var ourSoundManager:ISoundManager;
		protected var ourActionList:IActionList;
		protected var ourActionFactory:IActionFactory;
		protected var ourActionsFacade:ActionsFacade;

		function AbstractMapAsset(){
			ourDisplay			= new Sprite();
			ourDispatcher		= new EventDispatcher();
			ourIdentifier		= new NumericIdentifier();
			ourAnimationManager	= new EmptyAnimationManager(this as IMapAsset);
			ourSoundManager		= new SoundManager(this as IMapAsset);
			ourActionList 		= new CyclingActionList(this);
			ourActionsFacade	= new ActionsFacade();
		}	

		public function update():void{
			this.dispatchUpdateEvent();
			if(ourViewport)
				ourViewport.draw(this as IMapAsset);
		}

		protected function dispatchUpdateEvent():void
		{
			ourDispatcher.dispatchEvent(new MapAssetEvent(MapAssetEvent.UPDATE));	
		}
		
		public function getBody():b2Body
		{
			return ourBody;
		}
		
		public function setBody(myb2Body:b2Body):void
		{
			ourBody	= myb2Body;
		}
		
		public function getBodyDef():b2BodyDef
		{
			return ourBodyDef;
		}
		
		public function getWorld():IWorld
		{
			return ourWorld;
		}
		
		public function getActionFactory():IActionFactory
		{
			return ourActionFactory;	
		}
		
		public function getActionList():IActionList
		{
			return ourActionList;
		}		
		
		public function setViewport(myViewport:IMapAssetViewport):void
		{
			ourViewport = myViewport;
		}

		public function getViewport():IMapAssetViewport
		{
			return ourViewport;
		}
		
		public function getDisplay():DisplayObjectContainer
		{
			return ourDisplay;
		}
		
		public function getIdentifier():IIdentifier
		{
			return ourIdentifier;
		}
		
		public function setIdentifier(myIdentifier:IIdentifier):void
		{
			ourIdentifier	= myIdentifier;
		}
		
		public function getAnimationManager():IAnimationManager
		{
			return ourAnimationManager;
		}
		
		public function getSoundManager():ISoundManager {
			return ourSoundManager;
		}
		
		public function youAreOffTheViewport():void{
			ourDisplay.visible = false;
			//(this as IMapAsset).destroyBody();
		}
		
		public function youAreOnTheViewport(myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			ourDisplay.visible = true;
//			if(ourBody == null)
//				(this as IMapAsset).createBody(ourWorld, myX, myY, myRotation);
		}
		
		public function getDispatcher():IEventDispatcher{
			return ourDispatcher;
		}
	}
}
