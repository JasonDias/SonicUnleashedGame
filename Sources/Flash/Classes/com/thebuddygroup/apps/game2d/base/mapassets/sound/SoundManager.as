package com.thebuddygroup.apps.game2d.base.mapassets.sound 
{
	import flash.media.SoundChannel;	
	import flash.utils.getDefinitionByName;	
	import flash.media.Sound;	
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;	
	
	public class SoundManager implements ISoundManager
	{
		protected var ourMapAsset:IMapAsset;
		protected var ourSoundMap:Object;
		
		function SoundManager(myMapAsset:IMapAsset){
			ourSoundMap	= new Object();
			ourMapAsset	= myMapAsset;
		}
		
		public function getSoundFromMap(mySoundName:String):Sound{
			var mySound:Sound	= ourSoundMap[mySoundName];
			if(mySound == null){
				mySound	= createNewSoundFromLibrary(mySoundName);
			}
			return mySound;
		}
		
		public function createNewSoundFromLibrary(mySoundName:String):Sound{
			var mySound:Sound;
			var mySoundClass:Class	= getDefinitionByName(mySoundName) as Class;
			if(mySoundClass){
				mySound = new mySoundClass();
				if(mySound)
					addSoundToMap(mySoundName, mySound);
			}
			return mySound;
		}
		
		public function addSoundToMap(mySoundName:String, mySound:Sound):void{
			ourSoundMap[mySoundName]	= mySound;
		}
		
		public function playSound(mySoundName:String):SoundChannel {
			var mySound:Sound		= getSoundFromMap(mySoundName);			
			if(mySound)
				return mySound.play();
			else
				return null;			
		}
	}
}
