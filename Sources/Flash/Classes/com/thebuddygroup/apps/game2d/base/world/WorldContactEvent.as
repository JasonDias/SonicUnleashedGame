package com.thebuddygroup.apps.game2d.base.world 
{
	import Box2D.Dynamics.b2Body;	
	
	import flash.events.Event;
	

	public class WorldContactEvent extends Event 
	{
		public static const ADD:String		= 'Add';
		public static const PERSIST:String	= 'Persist';
		public static const REMOVE:String	= 'Remove';
		public static const RESULT:String	= 'Result';
		
		public var data:*;
		private var ourBody1;
		private var ourBody2:b2Body;

		public function WorldContactEvent(type:String, myData:*, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			data	= myData;
		}
		
		public function setCollisionBody1(myBody:b2Body):void
		{
			ourBody1 = myBody;	
		}
		
		public function setCollisionBody2(myBody:b2Body):void
		{
			ourBody2 = myBody;	
		}
		
		public function getCollisionBody2():b2Body
		{
			return ourBody2;	
		}
		
		public function getCollisionBody1():b2Body
		{
			return ourBody1;	
		}
		
	}
}
