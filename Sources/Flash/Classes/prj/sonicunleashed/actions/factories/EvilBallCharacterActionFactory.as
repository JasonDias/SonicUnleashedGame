package prj.sonicunleashed.actions.factories 
{
	import prj.sonicunleashed.actions.sonic.EvilBallCharacterActions;	
	import prj.sonicunleashed.actions.evilball.EvilBallCharacterBounceAwayAction;
	import prj.sonicunleashed.actions.sonic.EvilBallCharacterAttackSuccessAction;
	import prj.sonicunleashed.assets.EvilBallCharacter;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.PlayerCharacterActionFactory;	


	public class EvilBallCharacterActionFactory extends PlayerCharacterActionFactory implements IActionFactory 
	{
		public function EvilBallCharacterActionFactory(myTarget:EvilBallCharacter)
		{
			super(myTarget);
			
			initActionAndStoreInActionsMap(EvilBallCharacterActions.BOUNCE_AWAY_ACTION, new EvilBallCharacterBounceAwayAction());
			initActionAndStoreInActionsMap(PlayerCharacterActions.ATTACK_SUCCESS_ACTION, new EvilBallCharacterAttackSuccessAction());
		}
	}
}
