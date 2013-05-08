package com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions 
{
	import Box2D.Collision.Shapes.b2Shape;	
	

	public interface IFilterCondition 
	{
		function check(myShape1:b2Shape, myShape2:b2Shape):Boolean;
	}
}
