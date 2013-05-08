package prj.sonicunleashed.sound 
{
	import prj.sonicunleashed.assets.AbstractSpikeAsset;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.ISoundManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.SoundManager;	

	public class SpikeSoundManager extends SoundManager implements ISoundManager
	{
		public function SpikeSoundManager(myMapAsset:IMapAsset) {
			super(myMapAsset);
			//cache sounds
			createNewSoundFromLibrary(AbstractSpikeAsset.LIB_ASSET_DOINK_SOUND_CLASS_NAME);
		}
	}
}
