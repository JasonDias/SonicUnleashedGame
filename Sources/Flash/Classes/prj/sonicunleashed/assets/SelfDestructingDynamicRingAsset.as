package prj.sonicunleashed.assets 
{
	import com.carlcalderon.arthropod.Debug;	
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	import com.thebuddygroup.apps.tilescrollingengine.SpriteSheetAnimator;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import prj.sonicunleashed.assets.DynamicRingAsset;		


	public class SelfDestructingDynamicRingAsset extends DynamicRingAsset implements IMapAsset, ICollidable 
	{
		public static const LIB_ASSET_CLASS_NAME:String				= 'LibAssetRingAnimBitmap';
		public static const LIB_ASSET_RING_SOUND_CLASS_NAME:String	= 'LibAssetRingSound';
		
		private var ourSelfDestructTimer:Timer;		
		
		public function SelfDestructingDynamicRingAsset(myDestructInXSeconds:Number, myWorld:IWorld, myViewport:IMapAssetViewport, myX:Number = 0, myY:Number = 0, myRotation:Number = 0)
		{
			super(myWorld, myViewport, myX, myY, myRotation);
			
			ourSelfDestructTimer	= new Timer(int(myDestructInXSeconds*1000), 1);
			ourSelfDestructTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			//ourSelfDestructTimer.start();
		
			ourAnim.setFPS(60);
			
			ourBody.SetXForm(new b2Vec2(0,0), 0);
			ourBody.m_flags	|= b2Body.e_frozenFlag;
			ourBody.PutToSleep();
			//ourWorld.addMapAsset(this);
		}
		
		public function showThenSelfDestruct(myX:Number = 0, myY:Number = 0, myRotation:Number = 0, myVelocity:b2Vec2=null):void{
			if(!ourDisplay.parent)
				(ourViewport.getDisplay() as Sprite).addChild(ourDisplay);
			ourDisplay.visible = true;
			ourAnim.play();
			//if(ourBody){
			ourBody.m_flags &= ~b2Body.e_frozenFlag;
			ourBody.SetXForm(new b2Vec2(myX, myY), myRotation);
			ourBody.WakeUp();
			if(myVelocity)
				ourBody.SetLinearVelocity(myVelocity);
			update();				
			//}
			ourSelfDestructTimer.stop();
			ourSelfDestructTimer.start();			
		}

		private function onTimerComplete(myEvent:TimerEvent):void{
			deleteSelf();
		}
		
		override protected function deleteSelf():void{
			//Debug.log(this+' coin go away!!!');
			//ourSelfDestructTimer.stop();
			
			if(ourBody.m_world.m_lock)
			{
				setTimeout(deleteSelf, 1);
				return;
			}
			ourDisplay.visible = false;
			ourAnim.stop();
			
			ourBody.SetLinearVelocity(new b2Vec2(0,0));
			ourBody.SetXForm(new b2Vec2(-5,-5), 0);
			ourBody.m_flags	|= b2Body.e_frozenFlag;
			ourBody.PutToSleep();
			
			
//			if(this.parent)
//				this.parent.removeChild(this);
//			
//			if(ourBody){
//				//ourBody.PutToSleep();
//				//ourBody.GetShapeList().m_isSensor	= true;
//				if(ourBody.m_world.m_lock)
//				{
//					setTimeout(deleteSelf, 1);
//					return;
//				}
//				ourWorld.removeMapAsset(this);
//				ourWorld.destroyBody(ourBody);
//			}
		}
		
		override public function youAreOffTheViewport():void{
			
		}
		
		override public function youAreOnTheViewport(myX:Number=0, myY:Number=0, myRotation:Number=0):void{
			
		}	
	}
}
