package com.thebuddygroup.apps.game2d.base.mapassets {
	import com.thebuddygroup.apps.game2d.base.mapassets.animations.IAnimationAssetManager;
	import com.thebuddygroup.apps.game2d.base.mapassets.collidable.ICollidable;
	import com.thebuddygroup.apps.game2d.base.mapassets.inventory.IInventory;		

	public interface IPlayerCharacter extends IMapAsset, ICollidable{
		function getAnimationAssetManager():IAnimationAssetManager;
		function getInventory():IInventory;
	}
}
