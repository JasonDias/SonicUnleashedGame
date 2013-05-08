package com.thebuddygroup.apps.game2d.base.identifiers 
{
	import com.thebuddygroup.apps.game2d.base.IIdentifier;	

	public class NumericIdentifier implements IIdentifier
	{
		private var ourID:uint;
		
		private static var ourLastID:uint = 0;
		  
		public static function getNextID():uint
		{
			return ++ourLastID;
		}
		
		function NumericIdentifier(){
			ourID = NumericIdentifier.getNextID();
		}

		public function getID():uint
		{
			return ourID;
		}		
	}
}
