package prj.sonicunleashed.actions.sonic 
{
	import prj.sonicunleashed.Sonic;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;		


	public class SonicCollectRingAction extends AbstractPersistantAction implements IPersistantAction 
	{	
		public function start():void
		{
			var myHero:Sonic			= getTarget() as Sonic;
			var myInventory:IInventory	= myHero.getInventory(); 
			//myHero.getAnimationManager().animate(PlayerCharacterAnimation.RING);
			myInventory.addRing();
		}
		
		public function stop():void {
		}
		
		public function update():void {
		}
	}
}
