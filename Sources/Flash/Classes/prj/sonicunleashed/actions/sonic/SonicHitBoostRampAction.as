package prj.sonicunleashed.actions.sonic 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		

	public class SonicHitBoostRampAction extends AbstractPersistantAction implements IPersistantAction
	{
		public function start():void {
			var myMapAsset:IMapAsset					= getTarget() as IMapAsset;
			
			var myBody:b2Body	= myMapAsset.getBody();
			var myVel:b2Vec2	= myBody.GetLinearVelocity();
			if(myVel.x <= 0)
				return;
			
			myVel.y				= -15;
			myVel.x				= 20;
			
			myBody.SetLinearVelocity(myVel);
		}
		
		public function stop():void {
		}
		
		public function update():void {
		}
	}
}
