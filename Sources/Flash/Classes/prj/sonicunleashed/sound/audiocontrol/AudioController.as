package prj.sonicunleashed.sound.audiocontrol 
{
	import flash.events.EventDispatcher;	
	import flash.media.SoundTransform;	
	import flash.media.SoundMixer;	
	

	public class AudioController extends EventDispatcher 
	{
		private var ourPreviousVolume:Number = 100;
		
		private function dispatchVolumeChangedEvent():void
		{
			this.dispatchEvent(new AudioControllerEvent(AudioControllerEvent.VOLUME_CHANGED));	
		}
		
		public function muteAll():void
		{

			ourPreviousVolume = SoundMixer.soundTransform.volume;

			var mySoundTransform:SoundTransform = new SoundTransform();
			mySoundTransform.volume = 0;
			SoundMixer.soundTransform = mySoundTransform;  

			dispatchVolumeChangedEvent();
		}
		
		public function unmuteAll():void
		{
			var mySoundTransform:SoundTransform = new SoundTransform();
			mySoundTransform.volume = ourPreviousVolume;
			SoundMixer.soundTransform = mySoundTransform;  

			dispatchVolumeChangedEvent();
		}
		
		public function getVolume():Number
		{
			return SoundMixer.soundTransform.volume;
		}
		
	}
}
