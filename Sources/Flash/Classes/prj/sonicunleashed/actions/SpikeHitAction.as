package prj.sonicunleashed.actions 
{
	import prj.sonicunleashed.assets.AbstractSpikeAsset;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.AbstractPersistantAction;
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		


	public class SpikeHitAction extends AbstractPersistantAction implements IPersistantAction {
		public function SpikeHitAction() {
		}
		
		public function stop():void {
			
		}
		
		public function update():void {
		}
		
		public function start():void {
			var myMapAsset:IMapAsset	= getTarget() as IMapAsset;
			myMapAsset.getSoundManager().playSound(AbstractSpikeAsset.LIB_ASSET_DOINK_SOUND_CLASS_NAME);
		}
	}
}
