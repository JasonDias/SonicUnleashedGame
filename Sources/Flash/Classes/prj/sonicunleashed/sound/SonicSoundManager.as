package prj.sonicunleashed.sound 
{
	import prj.sonicunleashed.Sonic;	
	
	import flash.media.SoundChannel;	
	import flash.media.Sound;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.SoundManager;	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.sound.ISoundManager;import flash.utils.getDefinitionByName;		

	public class SonicSoundManager extends SoundManager implements ISoundManager
	{
		function SonicSoundManager(myMapAsset:IMapAsset){
			super(myMapAsset);
			//build cache now
			createNewSoundFromLibrary(Sonic.LIB_ASSET_JUMP_SOUND_CLASS_NAME);
			createNewSoundFromLibrary(Sonic.LIB_ASSET_RING_SPREAD_SOUND_CLASS_NAME);
			createNewSoundFromLibrary(Sonic.LIB_ASSET_OWWW_SOUND_CLASS_NAME);
			createNewSoundFromLibrary(Sonic.LIB_ASSET_SUPER_RUN_SOUND_CLASS_NAME);
		}		
	}
}
