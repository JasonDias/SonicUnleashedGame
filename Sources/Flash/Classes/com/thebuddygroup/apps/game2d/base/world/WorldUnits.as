package com.thebuddygroup.apps.game2d.base.world 
{
	import com.tbg.util.Conversion;	
	import com.thebuddygroup.apps.game2d.base.world.units.IWorldUnits;
	

	public class WorldUnits implements IWorldUnits 
	{
		private var ourPixelsToMetersConversion:Conversion;
		
		function WorldUnits(myPixelsToMetersConversion:Conversion)
		{
			ourPixelsToMetersConversion = myPixelsToMetersConversion;
		}

		public function getPixelsFromMeters(myMeters:Number):Number
		{
			return ourPixelsToMetersConversion.getKey(myMeters);
		}

		public function getMetersFromPixels(myPixels:Number):Number
		{
			return ourPixelsToMetersConversion.getValue(myPixels);
		}
	}
}
