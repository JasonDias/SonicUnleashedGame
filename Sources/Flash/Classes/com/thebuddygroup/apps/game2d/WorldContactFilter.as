package com.thebuddygroup.apps.game2d {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2ContactFilter;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.IContactFilter;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.IFilterCondition;
	
	import Box2D.Dynamics.b2Body;	

	public class WorldContactFilter extends b2ContactFilter implements IContactFilter
	{
		private var ourFilterMap:Object;
		private var ourFilterKey:Array;
		
		public function WorldContactFilter()
		{
			ourFilterMap = new Object();
			ourFilterKey = new Array();
		}

		private function addShapeFilter(myShape1:b2Shape, myShape2:b2Shape, myFilterCondition:IFilterCondition):void
		{
			var myAsset1:IMapAsset	= myShape1.m_body.m_userData as IMapAsset;
			var myAsset2:IMapAsset	= myShape2.m_body.m_userData as IMapAsset;
			if(myAsset1 == null || myAsset2 == null)
				return;
			
			ourFilterKey[0] = myAsset1.getIdentifier().getID();
			ourFilterKey[1] = myAsset2.getIdentifier().getID();
            ourFilterKey.sort();
			
			ourFilterMap[ourFilterKey.toString()] = myFilterCondition;
		}
		
		public function addFilter(myShapeList1:b2Shape, myShapeList2:b2Shape, myFilterCondition:IFilterCondition):void
		{
			var myShapeListValue:b2Shape = myShapeList1;
			var myShapeListValue2:b2Shape = myShapeList2;
			while(myShapeListValue)
			{
				addShapeFilter(myShapeListValue, myShapeList2, myFilterCondition);
				myShapeListValue = myShapeListValue.m_next;
			}
			while(myShapeListValue2)
			{
				addShapeFilter(myShapeListValue2, myShapeList1, myFilterCondition);
				myShapeListValue2 = myShapeListValue2.m_next;
			}
		}

		override public function ShouldCollide(myShape1:b2Shape, myShape2:b2Shape):Boolean
		{
			var myCheckGroups:Boolean = super.ShouldCollide(myShape1, myShape2);
			if(myCheckGroups)
			{
				var myAsset1:IMapAsset	= myShape1.m_body.m_userData as IMapAsset;
				var myAsset2:IMapAsset	= myShape2.m_body.m_userData as IMapAsset;
				if(myAsset1 == null || myAsset2 == null)
					return myCheckGroups;
				
				ourFilterKey[0] = myAsset1.getIdentifier().getID();
				ourFilterKey[1] = myAsset2.getIdentifier().getID();
                ourFilterKey.sort();
				var myFilterMap:IFilterCondition = ourFilterMap[ourFilterKey.toString()] as IFilterCondition;
				return (myFilterMap)?myFilterMap.check(myShape1, myShape2):true;
			} else 
				return false;
		}
	}
}