package prj.sonicunleashed.actions.sonic 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.Sonic;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;	

	public class SonicClimbAction extends AbstractPersistantAction implements IPersistantAction
	{
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myMapAsset:Sonic							= getTarget() as Sonic;
			if(isJumping(myMapAsset.getBody()))
				return;
			myMapAsset.extendClimbingArm();
//			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
//			var myMovementAnimationRequest:IAnimationRequest	= PlayerCharacterAnimation.getInstance().getAnimationRequest(PlayerCharacterAnimation.CLIMB);
//			myAnimationManager.removeAnimationRequest(myMovementAnimationRequest);
//			myAnimationManager.addAnimationRequest(myMovementAnimationRequest);
			
//			var myWorldUnits:IWorldUnits					= myMapAsset.getWorld().getWorldUnits();
//			var myBody:b2Body								= myMapAsset.getBody();
//			var myPos:b2Vec2								= myBody.GetPosition();
//			myPos.y											-= myWorldUnits.getMetersFromPixels(200);
//			//myBody.SetXForm(myPos, 0);
//			
//			TweenLite.to(this, 6/10, {bodyY:myPos.y});		
		}
		
//		public function set bodyY(myValue:Number)
//		{
//			var myMapAsset:IMapAsset						= getTarget() as IMapAsset;
//			var myBody:b2Body								= myMapAsset.getBody();
//			var myPos:b2Vec2								= myBody.GetPosition();
//			myPos.y											= myValue;
//			myBody.SetXForm(myPos, 0);
//		}
//		
//		public function get bodyY():Number{
//			var myMapAsset:IMapAsset						= getTarget() as IMapAsset;
//			var myBody:b2Body								= myMapAsset.getBody();
//			var myPos:b2Vec2								= myBody.GetPosition();
//			return myPos.y;
//		}

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
