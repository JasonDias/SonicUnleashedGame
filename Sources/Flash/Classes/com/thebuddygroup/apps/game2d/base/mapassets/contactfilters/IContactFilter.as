package com.thebuddygroup.apps.game2d.base.mapassets.contactfilters 
{
	import Box2D.Collision.Shapes.b2Shape;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.IFilterCondition;		


	public interface IContactFilter
	{
		function ShouldCollide(shape1:b2Shape, shape2:b2Shape):Boolean;
		function addFilter(myShape1:b2Shape, myShape2:b2Shape, myFilterCondition:IFilterCondition):void
		//function addFilterFromShapeList(myShapeList1:b2Shape, myShapeList2:b2Shape, myFilterCondition:IFilterCondition):void
	}
}
