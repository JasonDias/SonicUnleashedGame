package prj.sonicunleashed.sound.audiocontrol 
{
	import flash.events.Event;	
	

	public class AudioControllerEvent extends Event
	{
		public static const VOLUME_CHANGED:String = "volumeChanged";
		
		function AudioControllerEvent(myType : String, myBubbles : Boolean = false, myCancelable : Boolean = false)
		{
			super(myType, myBubbles, myCancelable);
		}
		
		public function getAudioController():AudioController
		{
			return this.target as AudioController;	
		}
		
	}
}
