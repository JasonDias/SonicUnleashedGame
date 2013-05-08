package  
{
	import prj.sonicunleashed.timer.IGameTimer;	
	
	public interface IGame
	{
		function init():void;
		function loadBGMusic():void;
		function loadMaps():void;
		function getGameName():String;
		function getGameTimer():IGameTimer;
		function endOfLevelReached():void;
	}
}
