package prj.sonicunleashed.actions 
{
	import prj.sonicunleashed.Sonic;
	import prj.sonicunleashed.assets.GrindRailCutScene;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;
	
	import flash.events.Event;		

	public class PlayGrindRailCutsceneAction extends AbstractPersistantAction implements IPersistantAction
	{
		public function stop():void {
		}
		
		public function update():void {
		}
		
		public function start():void {
			var mySonic:Sonic	= getTarget() as Sonic;
			if(!mySonic)
				return;
			
			mySonic.getWorld().stopRendering();
			var myCutscene:GrindRailCutScene	= mySonic.getGrindRailCutscene();
			myCutscene.addEventListener(Event.COMPLETE, onCutSceneComplete);
			myCutscene.playFromBeginning();
		}		
		
		private function onCutSceneComplete(myEvent:Event):void{
			var myCutscene:GrindRailCutScene	= myEvent.target as GrindRailCutScene;
			if(!myCutscene)
				throw new Error(this+' myCutscene should be a GrindRailCutScene');
			myCutscene.getMapAsset().getWorld().startRendering();
			myCutscene.removeEventListener(Event.COMPLETE, onCutSceneComplete);
		}
	}
}
