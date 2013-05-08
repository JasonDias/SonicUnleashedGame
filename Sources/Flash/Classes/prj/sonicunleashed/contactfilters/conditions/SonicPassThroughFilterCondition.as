package prj.sonicunleashed.contactfilters.conditions 
{
	import prj.sonicunleashed.Sonic;	
	
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.HeroPassThroughFilterCondition;
	import com.thebuddygroup.apps.game2d.base.mapassets.contactfilters.conditions.IFilterCondition;	

	public class SonicPassThroughFilterCondition extends HeroPassThroughFilterCondition implements IFilterCondition
	{
		public function SonicPassThroughFilterCondition(myHero:IPlayerCharacter) {
			super(myHero);
			throw new Error(this+' is not tested');
		}
		
		override public function check(myShape1:b2Shape, myShape2:b2Shape):Boolean {
			var myShapeList:b2Shape;				
			var myBodies:Array	= (ourHero as Sonic).getBodies();
			var myShouldCollide:Boolean;
			
			//Debug.log(this+' checking hero', Debug.YELLOW);
			for each(var myBody:b2Body in myBodies){
				myShapeList	= myBody.GetShapeList();
				while(myShapeList)
				{
					if(myShapeList == myShape1 || myShapeList == myShape2)
					{
						if(myBody.GetLinearVelocity().y >= 0){
							
						}else{
							return false;
						}
						//Debug.log(this+' found hero! should we collide? '+shouldCollide, Debug.GREEN)						
					}				
					myShapeList = myShapeList.m_next;
				}
			}
			//Debug.log(this+' never found hero', Debug.RED);
			return true;
		}
	}
}
