package com.thebuddygroup.apps.game2d.base.mapassets 
{

	public interface IHaveLifeEnergy
	{
		function decreaseLife(myAmount:Number=1):void;
		function increaseLife(myAmount:Number=1):void;
		function getLife():Number;
		function setLife(myAmount:Number):void;
	}
}
