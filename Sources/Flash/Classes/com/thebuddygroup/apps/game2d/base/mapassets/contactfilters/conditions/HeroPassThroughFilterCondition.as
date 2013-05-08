package com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions 
{
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;		


	public class HeroPassThroughFilterCondition extends AbstractFilterCondition implements IFilterCondition 
	{
		protected var ourHero:IMapAsset;
		
		public function HeroPassThroughFilterCondition(myHero:IMapAsset)
		{
			ourHero = myHero;
		}
		
		public function check(myShape1:b2Shape, myShape2:b2Shape):Boolean
		{
			var myHeroBody:b2Body		= ourHero.getBody();
			var myHeroShapeList:b2Shape	= myHeroBody.GetShapeList();
			
			//Debug.log(this+' checking hero', Debug.YELLOW);
			while(myHeroShapeList)
			{
				if(myHeroShapeList == myShape1 || myHeroShapeList == myShape2)
				{
					var shouldCollide:Boolean	= myHeroBody.GetLinearVelocity().y > -0.000001;
					//Debug.log(this+' found hero! should we collide? '+shouldCollide, Debug.GREEN)
					return shouldCollide;
				}				
				myHeroShapeList = myHeroShapeList.m_next;
			}
			//Debug.log(this+' never found hero', Debug.RED);
			return true;
		}
	}
}
