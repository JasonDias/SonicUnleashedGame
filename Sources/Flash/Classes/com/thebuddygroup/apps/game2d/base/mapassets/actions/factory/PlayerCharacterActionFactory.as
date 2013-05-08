package com.thebuddygroup.apps.game2d.base.mapassets.actions.factory {
	import com.thebuddygroup.apps.game2d.base.mapassets.IPlayerCharacter;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterJumpAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterMoveLeftAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterMoveRightAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterMovementWatchAction;	


	public class PlayerCharacterActionFactory extends AbstractActionFactory implements IActionFactory
	{
		public function PlayerCharacterActionFactory(myTarget:IPlayerCharacter)
		{
			super(myTarget);
			initActionAndStoreInActionsMap(PlayerCharacterActions.MOVE_LEFT_ACTION,		new PlayerCharacterMoveLeftAction());
			initActionAndStoreInActionsMap(PlayerCharacterActions.MOVE_RIGHT_ACTION,	new PlayerCharacterMoveRightAction());
			initActionAndStoreInActionsMap(PlayerCharacterActions.JUMP_ACTION,			new PlayerCharacterJumpAction());
			initActionAndStoreInActionsMap(PlayerCharacterActions.MOVE_WATCH_ACTION,	new PlayerCharacterMovementWatchAction());			
		}
	}
}
