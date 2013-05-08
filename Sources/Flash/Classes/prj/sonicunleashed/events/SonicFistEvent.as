package prj.sonicunleashed.events 
{
	import flash.events.Event;
	
	public class SonicFistEvent extends Event
	{
		public static const HIT_ENEMY:String	= 'hitEnemy';
		
		public function SonicFistEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
