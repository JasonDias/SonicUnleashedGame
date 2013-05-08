package  
{

	public class Application 
	{
		private static var ourApplicationMain:IApplicationMain;

		public static function getMain():IApplicationMain
		{
			return ourApplicationMain;
		}
		
		public static function setMain(myApplicationMain:IApplicationMain):void
		{
			ourApplicationMain = myApplicationMain;
		}
		
	}
}
