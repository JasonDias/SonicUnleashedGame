package com.thebuddygroup.apps.game2d.base.world 
{
	import flash.events.IEventDispatcher;	
	import flash.events.EventDispatcher;	
	
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2ContactResult;		


	public interface IContactListener
	{
		function getDispatcher():IEventDispatcher;
		function Add(point:b2ContactPoint):void;
		function Persist(point:b2ContactPoint):void;		
		function Remove(point:b2ContactPoint):void;
		function Result(point:b2ContactResult):void;
	}
}
