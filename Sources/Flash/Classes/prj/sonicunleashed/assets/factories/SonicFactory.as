package prj.sonicunleashed.assets.factories {
	import flash.display.DisplayObject;
	
	import com.thebuddygroup.apps.game2d.base.mapassets.IMapAsset;
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.PlayerCharacterAnimation;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.AbstractMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.mapassets.factories.IMapAssetFactory;
	import com.thebuddygroup.apps.game2d.base.world.IWorld;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IMapAssetViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.IViewport;
	import com.thebuddygroup.apps.game2d.base.world.viewport.MapAssetToViewportFollowConnector;
	
	import prj.sonicunleashed.Sonic;		


	public class SonicFactory extends AbstractMapAssetFactory implements IMapAssetFactory 
	{	
		public function createMapAsset(myWorld:IWorld, myViewport:IMapAssetViewport, myDisplayObject:DisplayObject, myX:Number=0, myY:Number=0, myRotation:Number=0):IMapAsset
		{
			
			var myHero:IMapAsset		= new Sonic(myWorld, myViewport, myX, myY, myRotation);
			
			//(myHero as Sonic).playAnimation(PlayerCharacterAnimation.IDLE);
			
			myViewport.setViewportWorldPosition(myHero.getBody().GetPosition().x, myHero.getBody().GetPosition().y);
			
			new MapAssetToViewportFollowConnector(myHero, myViewport);
			
			/*
			var myLeftRunningMovement:RunningPersistantBodyMovement		= new RunningPersistantBodyMovement(myHero.getBody(), -1.5, 15);
			var myRightRunningMovement:RunningPersistantBodyMovement	= new RunningPersistantBodyMovement(myHero.getBody(), 1.5, 15);
			var mySprintMovement:SprintBodyMovement						= new SprintBodyMovement(myHero.getBody(), 10, 80);			
			var myJumpMovement:JumpBodyMovement							= new JumpBodyMovement(myHero.getBody(), 10);
			var myJumpAnimation:PlayerAnimation							= new PlayerAnimation((myHero as PlayerCharacter), PlayerAnimation.JUMP);
			var myRunAnimation:PlayerAnimation							= new PlayerAnimation((myHero as PlayerCharacter), PlayerAnimation.RUN);
			var mySprintAnimation:PlayerAnimation						= new PlayerAnimation((myHero as PlayerCharacter), PlayerAnimation.SPRINT);
			var myHitAnimation:PlayerAnimation							= new PlayerAnimation((myHero as PlayerCharacter), PlayerAnimation.HIT);
			var myIdleAnimation:PlayerAnimation							= new PlayerAnimation((myHero as PlayerCharacter), PlayerAnimation.IDLE);
			
			
			var myRenderTrigger:RenderPersistantTrigger					= new RenderPersistantTrigger(myWorld.getRenderer());
			
			var myIdleTrigger:IdleBodyListeningTrigger	= new IdleBodyListeningTrigger(myHero.getBody());
				myIdleTrigger.setListeningTrigger(myRenderTrigger);
				myIdleTrigger.connect(myIdleAnimation);
						
			var myLeftKeyTrigger:IListeningTrigger = new ListeningKeyTrigger(myDisplayObject.stage, Keyboard.LEFT);
				myLeftKeyTrigger.setListeningTrigger(myRenderTrigger);
				myLeftKeyTrigger.connect(myLeftRunningMovement);
				myLeftKeyTrigger.connect(myRunAnimation);

			var myRightKeyTrigger:IListeningTrigger = new ListeningKeyTrigger(myDisplayObject.stage, Keyboard.RIGHT);
				myRightKeyTrigger.setListeningTrigger(myRenderTrigger);
				myRightKeyTrigger.connect(myRightRunningMovement);
				myRightKeyTrigger.connect(myRunAnimation);
				
			var myUpKeyTrigger:ITrigger = new KeyTrigger(myDisplayObject.stage, Keyboard.UP);
				myUpKeyTrigger.connect(myJumpMovement);
				myUpKeyTrigger.connect(myJumpAnimation);
				
			var mySpaceKeyTrigger:IListeningTrigger = new ListeningKeyTrigger(myDisplayObject.stage, Keyboard.SPACE);
				mySpaceKeyTrigger.setListeningTrigger(myRenderTrigger);
				mySpaceKeyTrigger.connect(mySprintMovement);
				mySpaceKeyTrigger.connect(mySprintAnimation);
				*/
			ourAssets.push(myHero);
			return myHero;
		}
	}
}
