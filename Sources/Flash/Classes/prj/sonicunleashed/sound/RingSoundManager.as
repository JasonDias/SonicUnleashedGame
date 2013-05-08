package prj.sonicunleashed.sound 
{
	import prj.sonicunleashed.assets.RingAsset;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.ISoundManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.SoundManager;	

	public class RingSoundManager extends SoundManager implements ISoundManager
	{
		public function RingSoundManager(myMapAsset:IMapAsset) {
			super(myMapAsset);
			//cache
			createNewSoundFromLibrary(RingAsset.LIB_ASSET_RING_SOUND_CLASS_NAME);
		}		
	}
}
