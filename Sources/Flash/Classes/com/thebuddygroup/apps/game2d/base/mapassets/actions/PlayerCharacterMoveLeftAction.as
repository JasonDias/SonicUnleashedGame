package com.thebuddygroup.apps.game2d.base.mapassets.actions 
{

	public class PlayerCharacterMoveLeftAction extends AbstractPlayerCharacterRunAction implements IPersistantAction
	{		
		function PlayerCharacterMoveLeftAction(){
			ourAccelBy		= -ourAccelBy;
			ourMaxVelocity	= -ourMaxVelocity;
		}		
	}
}
