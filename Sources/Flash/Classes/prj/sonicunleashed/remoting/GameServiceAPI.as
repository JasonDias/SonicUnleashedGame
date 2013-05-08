package prj.sonicunleashed.remoting {
	import flash.events.*;	
	import com.tbg.website.remoting.*;
	
	public class GameServiceAPI implements IGameServiceAPI{
		private var ourRemotingService:RemotingService;
		private var ourRemoteClassPath:String				= 'SonicGameService';

		public static const ECHO:String						= 'remote_echo';
		
		public static const SEND_POST_CARD:String			= 'sendPostCard';
		
		public static const SUBMIT_HIGH_SCORE:String		= 'submitHighScore';
		public static const GET_HIGH_SCORES:String			= 'getHighScores';
		public static const CLEAR_HIGH_SCORES:String		= 'clearHighScores';		
		
		function GameServiceAPI(myGatewayURL:String=null):void
		{
			if(myGatewayURL) setGateway(myGatewayURL);
		}

		public function setGateway(myGatewayURL:String):void
		{
			ourRemotingService	= new RemotingService();
			gatewayURL			= myGatewayURL;
		}
		
		public function setCredentials(myUser:String, myPass:String):void
		{
			ourRemotingService.connection.addHeader('Credentials', true, {userid: myUser, password: myPass});
		}

		//------------------------------------------------------------------------
		// Remoting Methods
		//------------------------------------------------------------------------

		public function sendRemoteRequest(myRequest:Request):void
		{
			ourRemotingService.request(myRequest);
		}

		public function createRemoteRequest(myFunctionName:String, ... args):Request
		{
			var myRequest:Request = new Request(ourRemoteClassPath + '.' + myFunctionName);
		
			//set vars to pass to remote function
			myRequest.setRequestVars(args);
			
			return myRequest;
		}

		//------------------------------------------------------------------------
		// Accessors / Mutators
		//------------------------------------------------------------------------

		public function get service():RemotingService {
			return ourRemotingService;
		}

		public function set gatewayURL(myURL:String):void {
			ourRemotingService.gatewayURL = myURL;
		}

		public function get gatewayURL():String {
			return ourRemotingService.gatewayURL;
		}
		
		//------------------------------------------------------------------------
		// Convenience Methods
		//------------------------------------------------------------------------
		private function cleanupEventListeners(myDispatcher:EventDispatcher):void
		{
			myDispatcher.removeEventListener(RemotingResponseEvent.RESULT, onRemoteResult);
			myDispatcher.removeEventListener(RemotingFaultEvent.FAULT,     onRemoteFault);
		}

		private function onRemoteResult(e:RemotingResponseEvent):void{
			cleanupEventListeners(e.currentTarget as EventDispatcher);
		}
		
		private function onRemoteFault(e:RemotingFaultEvent):void{
			cleanupEventListeners(e.currentTarget as EventDispatcher);
		}
		
		//------------------------------------------------------------------------
		// Service Methods (These match up with the remote API)
		//------------------------------------------------------------------------
		public function echo(myEcho:Object):Request
		{
			var myRequest:Request = createRemoteRequest(ECHO, myEcho);
			
			myRequest.addEventListener(RemotingResponseEvent.RESULT, onRemoteResult);
			myRequest.addEventListener(RemotingFaultEvent.FAULT,     onRemoteFault);
			
			sendRemoteRequest(myRequest);
			
			return myRequest;
		}

		public function sendPostCard(myFromName:String, myFromEmail:String, myToName:String, myToEmail:String):Request
		{
			var myRequest:Request = createRemoteRequest(SEND_POST_CARD, myFromName, myFromEmail, myToName, myToEmail);
			
			myRequest.addEventListener(RemotingResponseEvent.RESULT, onRemoteResult);
			myRequest.addEventListener(RemotingFaultEvent.FAULT,     onRemoteFault);
			
			sendRemoteRequest(myRequest);
			
			return myRequest;
		}

		public function submitHighScore(myName:String, myScore:uint, myGameName:String):Request
		{
			var myRequest:Request = createRemoteRequest(SUBMIT_HIGH_SCORE, myScore, myName, myGameName);
			
			myRequest.addEventListener(RemotingResponseEvent.RESULT, onRemoteResult);
			myRequest.addEventListener(RemotingFaultEvent.FAULT,     onRemoteFault);
			
			sendRemoteRequest(myRequest);
			
			return myRequest;
		}

		public function getHighScores(myGameName:String, myLimit:int = -1):Request
		{
			var myRequest:Request = createRemoteRequest(GET_HIGH_SCORES, myGameName, myLimit);
			
			myRequest.addEventListener(RemotingResponseEvent.RESULT, onRemoteResult);
			myRequest.addEventListener(RemotingFaultEvent.FAULT,     onRemoteFault);
			
			sendRemoteRequest(myRequest);
			
			return myRequest;
		}

		public function clearHighScores(myGameName:String):Request
		{
			var myRequest:Request = createRemoteRequest(CLEAR_HIGH_SCORES, myGameName);
			
			myRequest.addEventListener(RemotingResponseEvent.RESULT, onRemoteResult);
			myRequest.addEventListener(RemotingFaultEvent.FAULT,     onRemoteFault);
			
			sendRemoteRequest(myRequest);
			
			return myRequest;
		}		
	}
}