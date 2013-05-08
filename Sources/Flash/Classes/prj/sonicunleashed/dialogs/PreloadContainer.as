package prj.sonicunleashed.dialogs 
{
	import flash.net.URLVariables;	
	import flash.net.URLRequest;	
	
	import prj.sonicunleashed.progressbar.ProgressBar;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;	

	public class PreloadContainer extends MovieClip
	{
		private var ourLoader:Loader;
		private var ourProgressBar:ProgressBar;
		
		public function PreloadContainer() {
			ourLoader		= new Loader();
			ourProgressBar	= new ProgressBar();
			configureLoaderListeners(ourLoader.contentLoaderInfo);
			var myURLR:URLRequest		= new URLRequest(stage.loaderInfo.parameters.contentSWF || 'day_main.swf');
			/*
			var myURLVars:URLVariables	= new URLVariables();			
			for(var i:String in stage.loaderInfo.parameters)
				myURLVars[i]	= stage.loaderInfo.parameters[i];
			myURLR.data					= myURLVars;
			 * 
			 */			
			ourLoader.load(myURLR);
		}
		
		private function showLoadedContent():void{
			removeAllChildren();
			addChild(ourLoader);
		}
		
		private function showProgressBar():void{
			centerProgressBar();
			addChild(ourProgressBar);
		}
		
		private function centerProgressBar():void {
			var myWidth:Number	= loaderInfo.parameters.width || stage.stageWidth;
			var myHeight:Number	= loaderInfo.parameters.height || stage.stageHeight;
			ourProgressBar.x = Math.floor((myWidth - ourProgressBar.width)/2);
			ourProgressBar.y = Math.floor((myHeight - ourProgressBar.height)/2);
		}

		private function removeAllChildren():void{
			var myChild:DisplayObject;
			while(numChildren > 0){
				myChild	= getChildAt(0);
				removeChild(myChild);
			}
		}
		
		private function configureLoaderListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }

        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
            showLoadedContent();
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            trace("initHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
            showProgressBar();
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
            var myPercent:Number	= (event.bytesTotal > 0)?event.bytesLoaded / event.bytesTotal * 100:0;
            ourProgressBar.setProgressPercent(myPercent);
        }

        private function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
        }
	}
}
