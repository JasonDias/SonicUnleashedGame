package prj.sonicunleashed.remoting 
{
	import com.tbg.website.remoting.Request;	
	

	public interface IGameServiceAPI 
	{
		function echo(myEcho:Object):Request;

		function sendPostCard(myFromName:String, myFromEmail:String, myToName:String, myToEmail:String):Request;
		
		function submitHighScore(myName:String, myScore:uint, myGameName:String):Request;

		function getHighScores(myGameName:String, myLimit:int = -1):Request;

		function clearHighScores(myGameName:String):Request;
		
		
	}
}
