package com.thebuddygroup.apps.game2d.base.world.stats {
	import flash.system.System;	
	import flash.utils.getTimer;	
	
	import com.tbg.util.StringUtil;	
	
	import flash.text.TextField;	
	
	import com.thebuddygroup.apps.game2d.base.world.stats.IWorldStats;	
	
	import flash.events.Event;	
	import flash.display.MovieClip;
	

	public class WorldStatsDisplay extends MovieClip
	{
		public var bodyCounter:TextField;
		public var proxyCounter:TextField;
		public var jointCounter:TextField;
		public var fpsCounter:TextField;
		public var memCounter:TextField;
		
		private var ourLastTime:int;
		private var ourUpdateEveryNFrames:uint	= 5;
		private var ourFrameCount:uint			= 0;
		
		public function WorldStatsDisplay()
		{
			bodyCounter.text	= '0';
			proxyCounter.text	= '0';
			jointCounter.text	= '0';
			
			ourLastTime			= getTimer();
			addEventListener(Event.ENTER_FRAME, onEF);
		}
		
		private function onEF(myEvent:Event):void{
			if(++ourFrameCount % ourUpdateEveryNFrames != 0) return;	
			
			ourFrameCount	= 0;			
			var myFPS:Number;
			var myNow:int			= getTimer();
			var myElapsedTime:int	= myNow-ourLastTime;
			ourLastTime				= myNow;
			myFPS					= ourUpdateEveryNFrames/myElapsedTime*1000;
			fpsCounter.text			= Math.floor(myFPS).toString();
		}
		
		public function connectStats(myStats:IWorldStats):void
		{
			myStats.addEventListener(Event.CHANGE, onStatsChange);
		}
		
		private function onStatsChange(myEvent:Event):void
		{
			updateDisplay(myEvent.target as IWorldStats);
		}
		
		private function updateDisplay(myStats:IWorldStats):void
		{
			bodyCounter.text	= StringUtil.number_format(myStats.getBodyCount());
			proxyCounter.text	= StringUtil.number_format(myStats.getProxyCount());
			jointCounter.text	=  StringUtil.number_format(myStats.getJointCount());
			memCounter.text		= StringUtil.number_format((Math.round(System.totalMemory/1024)));
		}
	}
}
