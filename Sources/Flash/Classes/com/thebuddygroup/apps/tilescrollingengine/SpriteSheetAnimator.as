package com.thebuddygroup.apps.tilescrollingengine {
	import flash.display.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.utils.Timer;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.AbstractMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.AnimationAssetEvent;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAsset;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;	

	public class SpriteSheetAnimator extends AbstractMapAsset implements IMapAsset, IAnimationAsset
	{
		private var ourBlitCanvas:BitmapData;
		private var ourTileBMP:BitmapData;
		private var ourTile:Bitmap;
		private var ourFrameCount:uint;
		private var ourTotalColumns:uint;		
		private var ourCurrentFrame:uint;		
		private var ourTotalRows:uint;		
		private var ourFlipAnimationHorizontal:Boolean;
		private var ourIdentityMatrix:Matrix;
		private var ourHorizontalFlipMatrix:Matrix;
		private var ourFPS:uint;
		private var ourFrameTimer:Timer;
		
		public var isPlaying:Boolean;
		public var isNonLooping:Boolean;
		
		public function SpriteSheetAnimator(tileBitmapData:BitmapData, tileWidth:uint, tileHeight:uint, frameCount:uint, framesPerSecond:uint=30, myIsLooping:Boolean=true) 
		{
			super();
			
			ourFrameCount			= frameCount;
			ourTileBMP				= tileBitmapData;
			ourBlitCanvas			= new BitmapData(tileWidth, tileHeight, true, 0x00000000);
			ourTile					= new Bitmap(ourBlitCanvas);
			
			ourDisplay.addChild(ourTile);
			ourTotalColumns			= Math.ceil(ourTileBMP.width / tileWidth);
			ourTotalRows			= Math.ceil(frameCount / ourTotalColumns);
			
			ourFlipAnimationHorizontal	= false;
			ourIdentityMatrix			= new Matrix();
			ourHorizontalFlipMatrix		= new Matrix(-1, 0, 0, 1, tileWidth, 0);
			ourFPS						= framesPerSecond;
			ourFrameTimer				= new Timer(1/ourFPS*1000);		
			ourFrameTimer.addEventListener(TimerEvent.TIMER, goNext);	
			isPlaying					= false;
			isNonLooping				= !myIsLooping;
		}
		
		public function play():void
		{
			if(isPlaying)
				return;
			
			ourCurrentFrame			= 0;
			isPlaying				= true;
			drawFrame(ourCurrentFrame);
			ourFrameTimer.start();
			ourDispatcher.dispatchEvent(new AnimationAssetEvent(AnimationAssetEvent.ANIMATION_START));
		}
		
		public function stop():void
		{
			stopAnimation();
			ourDispatcher.dispatchEvent(new AnimationAssetEvent(AnimationAssetEvent.ANIMATION_INTERRUPT));
		}
		
		private function stopAnimation():void{
			isPlaying				= false;
			ourFrameTimer.stop();
		}
		
		private function goNext(event:TimerEvent):void
		{
			ourCurrentFrame++;
			if(ourCurrentFrame == ourFrameCount){
				ourCurrentFrame = 0;
				if(isNonLooping){
					stopAnimation();
					ourDispatcher.dispatchEvent(new AnimationAssetEvent(AnimationAssetEvent.ANIMATION_COMPLETE));
					return;
				}
			}
			
			drawFrame(ourCurrentFrame);
		}
		public function drawFrame(myFrameNumber:uint):void{
			var myX:uint				= int(myFrameNumber % ourTotalColumns)* ourBlitCanvas.width;
			var myY:uint				= int(myFrameNumber / ourTotalColumns)* ourBlitCanvas.height;
			var mySourceRect:Rectangle	= new Rectangle(myX, myY, ourBlitCanvas.width, ourBlitCanvas.height);
			
			ourBlitCanvas.lock();
			ourBlitCanvas.fillRect(ourBlitCanvas.rect, 0x00000000);
			ourBlitCanvas.copyPixels(ourTileBMP, mySourceRect, new Point(0,0));			 
			ourBlitCanvas.unlock();
			
			ourDispatcher.dispatchEvent(new AnimationAssetEvent(AnimationAssetEvent.ANIMATION_STEP));
		}
		
		public function setFPS(myFPS:uint):void{
			ourFPS				= myFPS;
			ourFrameTimer.delay	= 1/myFPS*1000;			
		}
		
		public function createBody(myWorld:IWorld, myX:Number = 0, myY:Number = 0, myRotation:Number = 0):void
		{
		}
		
		public function destroyBody():void
		{
		}
		
		public function show() : void {			
			ourDisplay.visible = true;
		}
		
		public function hide() : void {
			ourDisplay.visible = false;
		}
		
		public function stopAndHide():void{
			stop();
			hide();
		}
		
		public function faceLeft():void{
			ourTile.transform.matrix	= ourHorizontalFlipMatrix;
		}
		
		public function faceRight():void{
			ourTile.transform.matrix	= ourIdentityMatrix;
		}
		
		public function playAndShow():void{
			play();
			show();
		}
		
		public function getFPS():uint {
			return ourFPS;
		}		
	}
}
