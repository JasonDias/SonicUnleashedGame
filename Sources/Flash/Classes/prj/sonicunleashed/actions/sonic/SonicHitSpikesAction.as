package prj.sonicunleashed.actions.sonic 
{
	import prj.sonicunleashed.Sonic;	
	
	import com.carlcalderon.arthropod.Debug;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;	


	public class SonicHitSpikesAction extends AbstractPersistantAction implements IPersistantAction {
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myActionsFacade:ActionsFacade			= ActionsFacade.getInstance();
			var myMapAsset:IMapAsset					= getTarget() as IMapAsset;
			
			myMapAsset.getSoundManager().playSound(Sonic.LIB_ASSET_OWWW_SOUND_CLASS_NAME);
			myActionsFacade.addActionAndStart(SonicActions.LOSE_ALL_RINGS_ACTION, myMapAsset);			
			myActionsFacade.addActionAndStart(SonicActions.BOUNCE_AWAY_ACTION, myMapAsset);			
		}
	}
}
