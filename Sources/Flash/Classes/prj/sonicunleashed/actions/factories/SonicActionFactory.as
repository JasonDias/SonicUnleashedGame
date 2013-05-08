package prj.sonicunleashed.actions.factories 
{
	import prj.sonicunleashed.Sonic;
	import prj.sonicunleashed.actions.PlayGrindRailCutsceneAction;
	import prj.sonicunleashed.actions.RingActions;
	import prj.sonicunleashed.actions.SpikeActions;
	import prj.sonicunleashed.actions.sonic.SonicActions;
	import prj.sonicunleashed.actions.sonic.SonicAttackAction;
	import prj.sonicunleashed.actions.sonic.SonicBounceAwayAction;
	import prj.sonicunleashed.actions.sonic.SonicClimbAction;
	import prj.sonicunleashed.actions.sonic.SonicCollectRingAction;
	import prj.sonicunleashed.actions.sonic.SonicDanceAction;
	import prj.sonicunleashed.actions.sonic.SonicHitBoostRampAction;
	import prj.sonicunleashed.actions.sonic.SonicHitBoostRampPlayGrindRailCutsceneAction;
	import prj.sonicunleashed.actions.sonic.SonicHitEvilBallAction;
	import prj.sonicunleashed.actions.sonic.SonicHitSpikesAction;
	import prj.sonicunleashed.actions.sonic.SonicJumpAction;
	import prj.sonicunleashed.actions.sonic.SonicLoseAllRingsAction;
	import prj.sonicunleashed.actions.sonic.SonicSuperJumpAction;
	import prj.sonicunleashed.actions.sonic.SonicSuperRunAction;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.PlayerCharacterActions;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.PlayerCharacterActionFactory;		


	public class SonicActionFactory extends PlayerCharacterActionFactory implements IActionFactory
	{
		public function SonicActionFactory(myTarget:Sonic) {
			super(myTarget);
			initActionAndStoreInActionsMap(SonicActions.JUMP_ACTION,			new SonicJumpAction());
			initActionAndStoreInActionsMap(SpikeActions.SPIKE_HIT_ACTION,		new SonicHitSpikesAction());
			initActionAndStoreInActionsMap(SonicActions.LOSE_ALL_RINGS_ACTION,	new SonicLoseAllRingsAction());
			initActionAndStoreInActionsMap(RingActions.RING_HIT_ACTION,			new SonicCollectRingAction());
			initActionAndStoreInActionsMap(SonicActions.BOUNCE_AWAY_ACTION,		new SonicBounceAwayAction());
			initActionAndStoreInActionsMap(SonicActions.SUPER_JUMP_ACTION,		new SonicSuperJumpAction());
			initActionAndStoreInActionsMap(SonicActions.SUPER_RUN_ACTION,		new SonicSuperRunAction());
			initActionAndStoreInActionsMap(PlayerCharacterActions.DANCE_ACTION, new SonicDanceAction());
			
			initActionAndStoreInActionsMap(PlayerCharacterActions.ATTACK_ACTION,	new SonicAttackAction());
			initActionAndStoreInActionsMap(PlayerCharacterActions.CLIMB_ACTION,		new SonicClimbAction());
			
			initActionAndStoreInActionsMap(SonicActions.EVIL_BALL_HIT_ACTION,						new SonicHitEvilBallAction());
			initActionAndStoreInActionsMap(SonicActions.BOOST_RAMP_HIT_ACTION,						new SonicHitBoostRampAction());
			initActionAndStoreInActionsMap(SonicActions.PLAY_GRIND_RAIL_CUTSCENE_ACTION,			new PlayGrindRailCutsceneAction());
			initActionAndStoreInActionsMap(SonicActions.BOOST_RAMP_PLAY_GRIND_RAIL_CUTSCENE_ACTION,	new SonicHitBoostRampPlayGrindRailCutsceneAction());
		}
	}
}
