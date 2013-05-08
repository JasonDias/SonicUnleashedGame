package prj.sonicunleashed.sound.audiocontrol 
{
	import flash.events.MouseEvent;	
	import flash.display.MovieClip;	
	

	public class MuteControllerMovieClip extends MovieClip
	{
		public var _waves:MovieClip;
		private var ourAudioController:AudioController;
		
		public function MuteControllerMovieClip()
		{
			this.addEventListener(MouseEvent.CLICK, clickedSelf);	
			this.buttonMode = true;
		}
		
		private function clickedSelf(myEvent:MouseEvent):void
		{
			if(!ourAudioController)
				return;
			if(ourAudioController.getVolume() > 0)
				ourAudioController.muteAll();
			else
				ourAudioController.unmuteAll();
		}

		public function connectToAudioController(myAudioController:AudioController):void
		{
			myAudioController.addEventListener(AudioControllerEvent.VOLUME_CHANGED, volumeChanged);
			ourAudioController = myAudioController;
		}

		private function volumeChanged(myEvent:AudioControllerEvent):void
		{
			if(myEvent.getAudioController().getVolume() > 0)
				_waves.visible = true;
			else
				_waves.visible = false;
		}
	}
}
