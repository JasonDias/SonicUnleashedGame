package com.thebuddygroup.apps.game2d.base.mapassets.actions.list.connectors {
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.actions.IPersistantAction;		


	public class KeyToPersistantActionConnector extends AbstractPersistantActionConnector implements IPersistantActionConnector
	{
		private var ourListeningDisplayObject:DisplayObjectContainer;
		private var ourKeyCode:uint;
		private var ourKeyIsDown:Boolean;
		
		public function KeyToPersistantActionConnector(myListeningDisplayObjectContainer:DisplayObjectContainer, myKeyCode:uint, myAction:IPersistantAction)
		{
			ourKeyIsDown	= false;
			ourListeningDisplayObject = myListeningDisplayObjectContainer;
			ourKeyCode = myKeyCode;
			connectToPersistantAction(myAction);
			ourListeningDisplayObject.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			ourListeningDisplayObject.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		private function keyPressed(myEvent:KeyboardEvent):void
		{
			if(myEvent.keyCode == ourKeyCode && !ourKeyIsDown)
			{
				ourKeyIsDown	= true;
				ourAction.start();
				myEvent.updateAfterEvent();
			}				
		}
		
		private function keyReleased(myEvent:KeyboardEvent):void
		{
			if(myEvent.keyCode == ourKeyCode && ourKeyIsDown)
			{
				ourKeyIsDown	= false;
				ourAction.stop();
				myEvent.updateAfterEvent();
			}
		} 
		

	}
}

