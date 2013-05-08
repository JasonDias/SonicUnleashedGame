package prj.sonicunleashed.actions.factories {
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.AbstractActionFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.factory.IActionFactory;
	
	import prj.sonicunleashed.actions.SpikeActions;
	import prj.sonicunleashed.actions.SpikeHitAction;	


	public class SpikeAssetActionFactory extends AbstractActionFactory implements IActionFactory {
		public function SpikeAssetActionFactory(myTarget:IMapAsset)
		{
			super(myTarget);
			
			initActionAndStoreInActionsMap(SpikeActions.SPIKE_HIT_ACTION, new SpikeHitAction());
		}
	}
}
