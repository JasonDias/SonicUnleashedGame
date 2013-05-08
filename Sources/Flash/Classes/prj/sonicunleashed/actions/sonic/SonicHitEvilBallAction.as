package prj.sonicunleashed.actions.sonic 
{
	import com.carlcalderon.arthropod.Debug;	
	
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.actions.SpikeActions;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		

	public class SonicHitEvilBallAction extends AbstractPersistantAction implements IPersistantAction
	{
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myActionsFacade:ActionsFacade			= ActionsFacade.getInstance();
			var myMapAsset:IMapAsset					= getTarget() as IMapAsset;
			
			if(!isJumping(myMapAsset.getBody())) {
				myActionsFacade.addActionAndStart(SpikeActions.SPIKE_HIT_ACTION, myMapAsset);
			}else{
				Debug.log(this+' in the air, should kill enemy');
			}
		}
		
		protected function isJumping(myBody:b2Body):Boolean{
			var myManifold:b2Manifold;
			for (var myCurrentContactEdge:b2ContactEdge = myBody.m_contactList; myCurrentContactEdge != null ; myCurrentContactEdge = myCurrentContactEdge.next){
				myManifold = myCurrentContactEdge.contact.GetManifolds()[0];
				if (myCurrentContactEdge.contact.GetShape1().GetBody() == myBody){
					if (myManifold.normal.y > 0) return false;
				}else{
					if (myManifold.normal.y < 0) return false;
				}
			}
			return true;
		}
	}
}
