package prj.sonicunleashed.dialogs.assets 
{
	import gs.TweenLite;	
	
	import flash.events.MouseEvent;	
	import flash.display.MovieClip;	
	

	public class GoldPlateButton extends MovieClip
	{
		private var ourNormalX:Number;
		private var ourRollOverXMovement:Number;

		function GoldPlateButton()
		{
			this.buttonMode = true;
			ourNormalX = this.x;
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverButton);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOffButton);
			ourRollOverXMovement = 10;	
		}
		
		private function rollOverButton(event:MouseEvent):void
		{
			TweenLite.to(this, .1, {x:ourNormalX + ourRollOverXMovement});
		}
		
		private function rollOffButton(event:MouseEvent):void
		{
			TweenLite.to(this, .1, {x:ourNormalX});
		}
	}
}
