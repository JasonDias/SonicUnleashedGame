package  
{
	import com.tbg.dialog.IDialogManager;
	
	import prj.sonicunleashed.remoting.IGameServiceAPI;	

	public interface IApplicationMain
	{
		function getGame():IGame;
		function getDialogManager():IDialogManager;
		function getRemotingServiceManager():IGameServiceAPI;
		
		//function getGameStateManager():IGameStateManager;
	}
}
