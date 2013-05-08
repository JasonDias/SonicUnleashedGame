package prj.sonicunleashed.actions.factories {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.AbstractActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;
	
	import prj.sonicunleashed.actions.RingActions;
	import prj.sonicunleashed.actions.RingHitAction;	


	public class RingAssetActionFactory extends AbstractActionFactory implements IActionFactory {
		public function RingAssetActionFactory(myTarget:IMapAsset) {
			super(myTarget);
			initActionAndStoreInActionsMap(RingActions.RING_HIT_ACTION, new RingHitAction());
		}
	}
}
