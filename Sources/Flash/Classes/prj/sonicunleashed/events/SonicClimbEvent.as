package prj.sonicunleashed.events 
{
	import flash.events.Event;
	
	public class SonicClimbEvent extends Event
	{
		public static const HIT_PLATFORM:String	= 'hitPlatform';
		
		public function SonicClimbEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
