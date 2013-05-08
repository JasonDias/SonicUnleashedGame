package com.thebuddygroup.apps.game2d.base.mapassets.sound 
{
	import flash.media.SoundChannel;	
	import flash.media.Sound;	
	
	public interface ISoundManager
	{
		function playSound(mySoundName:String):SoundChannel;
		function getSoundFromMap(mySoundName:String):Sound;
		function addSoundToMap(mySoundName:String, mySound:Sound):void;
		function createNewSoundFromLibrary(mySoundName:String):Sound;
	}
}
