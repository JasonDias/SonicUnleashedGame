package prj.sonicunleashed.actions.sonic 
{
	import prj.sonicunleashed.Sonic;	
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.ActionsFacade;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;	

	public class SonicHitBoostRampPlayGrindRailCutsceneAction extends AbstractPersistantAction implements IPersistantAction
	{		
		public function start():void {
			var myActionsFacade:ActionsFacade		= ActionsFacade.getInstance();
			var myMapAsset:Sonic					= getTarget() as Sonic;
			var myBodies:Array						= myMapAsset.getBodies();
			for each(var myBody:b2Body in myBodies){
				var myPos:b2Vec2	= myBody.GetPosition();
				myPos.x				+= 10;
				myPos.y				-= 6;
			
				myBody.SetLinearVelocity(new b2Vec2(15, 8));
				myBody.SetXForm(myPos, myBody.GetAngle());
			}
			myActionsFacade.addActionAndStart(SonicActions.PLAY_GRIND_RAIL_CUTSCENE_ACTION, myMapAsset);
		}
		
		public function stop():void {
		}
		
		public function update():void {
		}		
	}
}
