package com.thebuddygroup.gui 
{
	import flash.display.MovieClip;	
	
	import com.tbg.gui.IPlaceable;	
	

	public class MovieClipToPlaceableConnector 
	{
		private var ourMovieClip:MovieClip;
		private var ourPlaceable:IPlaceable;
		
		function MovieClipToPlaceableConnector(myMovieClip:MovieClip, myPlaceable:IPlaceable)
		{
			ourMovieClip	= myMovieClip;
			ourPlaceable	= myPlaceable;
		}
		
		public function applyMovieClipBoundsToPlaceable():void{
			ourPlaceable.setX(ourMovieClip.x);
			ourPlaceable.setY(ourMovieClip.y);
			ourPlaceable.setWidth(ourMovieClip.width);
			ourPlaceable.setHeight(ourMovieClip.height);
		}
		
		public function applyPlaceableToMovieClip():void{
			ourMovieClip.x		= ourPlaceable.getX();
			ourMovieClip.y		= ourPlaceable.getY();
			ourMovieClip.width	= ourPlaceable.getWidth();
			ourMovieClip.height	= ourPlaceable.getHeight();
		}
	}
}
