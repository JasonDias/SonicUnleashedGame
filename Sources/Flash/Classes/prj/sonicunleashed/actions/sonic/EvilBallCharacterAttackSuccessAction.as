package prj.sonicunleashed.actions.sonic 
{
	import com.carlcalderon.arthropod.Debug;
	import com.thebuddygroup.apps.game2d.base.mapassets.IHaveLifeEnergy;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;		

	public class EvilBallCharacterAttackSuccessAction extends AbstractPersistantAction implements IPersistantAction
	{
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myMapAsset:IMapAsset							= getTarget() as IMapAsset; 
			ActionsFacade.getInstance().addActionAndStart(EvilBallCharacterActions.BOUNCE_AWAY_ACTION, myMapAsset);
		}
	}
}
