package com.robinkruyt.Ypsilon.menu
{
	import org.flixel.*;
	
	public class MenuItem extends FlxSprite
	{
		[Embed(source='assets/sprites/menu.png')] private var menuImg:Class;
		public function MenuItem(X:Number=0, Y:Number=0, type:uint = 0)
		{
			super(X, Y, null);
			loadGraphic(menuImg,false,false,16,16);
			frame = type;
			scrollFactor = new FlxPoint(0,0);
		}
	}
}