package prj.sonicunleashed.remoting 
{
	import com.tbg.website.remoting.RemotingFaultEvent;	
	

	public class GameServiceError 
	{
		private var ourErrorCode:Number;
		private var ourDescription:String;
		
		public static function createFromRemotingFaultEvent(myFaultEvent:RemotingFaultEvent):GameServiceError
		{
			var myError:GameServiceError = new GameServiceError();
			var myErrorDescription:String = myFaultEvent.faultError.description;
			if(myErrorDescription.indexOf("|") < 0)
			{
				myError.setErrorCode(0);
				myError.setDescription(myErrorDescription);
			}
			else
			{
				var myFaultDescriptionArray:Array = String(myFaultEvent.faultError.description).split("|");
				myError.setErrorCode(new Number(String(myFaultDescriptionArray[0]).substring(1)))
				myError.setDescription(myFaultDescriptionArray[1]);
			}
			
			return myError;
		}
		public function setErrorCode(myErrorCode:Number):void
		{
			ourErrorCode = myErrorCode;
		}
		
		public function setDescription(myDescription:String):void
		{
			ourDescription = myDescription;
		}
		
		public function getErrorCode():Number
		{
			return ourErrorCode;	
		}
		
		public function getDescription():String
		{
			return ourDescription;	
		}
	}
}
