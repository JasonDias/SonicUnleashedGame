package com.thebuddygroup.apps.game2d.base.world 
{
	import flash.events.IEventDispatcher;	
	
	import Box2D.Dynamics.b2ContactListener;	
	
	import com.thebuddygroup.apps.game2d.base.world.IContactListener;	
	
	import Box2D.Dynamics.Contacts.b2ContactResult;	
	import Box2D.Collision.b2ContactPoint;	
	
	import flash.events.EventDispatcher;	


	public class WorldContactListener extends b2ContactListener implements IContactListener 
	{
		private var ourDispatcher:IEventDispatcher;
		
		function WorldContactListener():void{
			ourDispatcher	= new EventDispatcher();
		}
		
		override public function Add(point:b2ContactPoint):void{
			var myEvent:WorldContactEvent = new WorldContactEvent(WorldContactEvent.ADD, point);
				myEvent.setCollisionBody1(point.shape1.m_body);
				myEvent.setCollisionBody2(point.shape2.m_body);
			ourDispatcher.dispatchEvent(myEvent);
		}
		
		override public function Persist(point: b2ContactPoint):void{
			var myEvent:WorldContactEvent = new WorldContactEvent(WorldContactEvent.PERSIST, point);
				myEvent.setCollisionBody1(point.shape1.m_body);
				myEvent.setCollisionBody2(point.shape2.m_body);
			ourDispatcher.dispatchEvent(myEvent);
		}
		
		override public function Remove(point: b2ContactPoint):void{
			
			var myEvent:WorldContactEvent = new WorldContactEvent(WorldContactEvent.REMOVE, point);
				myEvent.setCollisionBody1(point.shape1.m_body);
				myEvent.setCollisionBody2(point.shape2.m_body);
			ourDispatcher.dispatchEvent(myEvent);
		}
		
		/*
		 * Use this one to detect the actual collision between objects shapes
		 */
		override public function Result(point: b2ContactResult):void{
			var myEvent:WorldContactEvent = new WorldContactEvent(WorldContactEvent.RESULT, point);
				myEvent.setCollisionBody1(point.shape1.m_body);
				myEvent.setCollisionBody2(point.shape2.m_body);
			ourDispatcher.dispatchEvent(myEvent);
		}
		
		public function getDispatcher():IEventDispatcher
		{
			return ourDispatcher;
		}
	}
}

