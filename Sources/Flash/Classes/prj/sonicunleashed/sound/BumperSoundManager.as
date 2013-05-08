package prj.sonicunleashed.sound 
{
	import prj.sonicunleashed.assets.BumperAsset;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.ISoundManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.SoundManager;	

	public class BumperSoundManager extends SoundManager implements ISoundManager
	{
		public function BumperSoundManager(myMapAsset:IMapAsset) {
			super(myMapAsset);
			//cache
			createNewSoundFromLibrary(BumperAsset.LIB_ASSET_SPRING_SOUND_CLASS_NAME);
		}
	}
}
