package prj.sonicunleashed.actions.sonic 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.Sonic;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPlayerCharacterRunAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationRequest;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;	

	public class SonicSuperRunAction extends AbstractPlayerCharacterRunAction implements IPersistantAction 
	{
		private var ourAbsAccelBy:Number		= 9;
		private var ourAbsMaxVelocity:Number	= 45;
		private var ourMinEnergy:Number			= 0.05;
		
		function SonicSuperRunAction(){
			ourAbsAccelBy		= ourAccelBy		= 9;
			ourAbsMaxVelocity	= ourMaxVelocity	= 45;
		}
		
		override public function update():void{
			var myMapAsset:Sonic		= getTarget() as Sonic;
			var myInventory:IInventory	= myMapAsset.getInventory();
			if(myMapAsset.getInventory().getEnergy() == 0){
				stop();
				return;
			}
			var myAnimationManager:IAnimationManager			= myMapAsset.getAnimationManager();
			var myFacingDirection:String						= (ourAccelBy >=0)?PlayerCharacterAnimation.FACE_RIGHT:PlayerCharacterAnimation.FACE_LEFT;
			var myFacingAnimationRequest:IAnimationRequest		= PlayerCharacterAnimation.getInstance().getAnimationRequest(myFacingDirection);			
			
			myAnimationManager.addAnimationRequest(myFacingAnimationRequest);
			myInventory.decreaseEnergy();
			super.update();
		}
		
		override public function start():void
		{
			var myMapAsset:Sonic						= getTarget() as Sonic;
			if(myMapAsset.getInventory().getEnergy() < ourMinEnergy)
				return;
				
			var myBody:b2Body							= myMapAsset.getBody();
			if(isJumping(myBody))
				return;
			
			var myVelocity:b2Vec2						= myBody.GetLinearVelocity();
			if(myVelocity.x == 0)
				return;
				
			dispatchAddToListEvent();
			if(myVelocity.x < 0){
				//moving left
				ourAccelBy		= -ourAbsAccelBy;
				ourMaxVelocity	= -ourAbsMaxVelocity;
			}else{
				ourAccelBy		= ourAbsAccelBy;
				ourMaxVelocity	= ourAbsMaxVelocity;
			}
			
			update();
			
			myMapAsset.getSoundManager().playSound(Sonic.LIB_ASSET_SUPER_RUN_SOUND_CLASS_NAME);
		}
		
		override public function stop():void
		{
			dispatchRemoveFromListEvent();
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
