package com.robinkruyt.Ypsilon
{
	import org.flixel.*;
	
	public class Cloud extends FlxSprite
	{
		[Embed(source = "assets/sprites/clouds.png")] 
		private var ImgCloud:Class;
		
		private var _topLeft:FlxPoint;
		private var _bottomRight:FlxPoint;
		
		public function Cloud(topLeft:FlxPoint, bottomRight:FlxPoint)
		{
			super(topLeft.x, topLeft.y, null);
			
			_topLeft		=	topLeft;
			_bottomRight	=	bottomRight;
			
			loadGraphic(ImgCloud,false,false,35,30);
			
			resetCloud();
		}
		
		private function resetCloud():void
		{
			frame = Math.round(FlxU.random() * 2);
			
			x = FlxU.random() * _bottomRight.x + _topLeft.x;
			y = FlxU.random() * _bottomRight.y + _topLeft.y;
			
			velocity.x = 10*FlxU.random()+5;
			velocity.y = 0;
		}
		
		override public function update():void
		{
			super.update();
			
			if(getScreenXY().x>FlxG.width)
			{
				resetCloud();
			}
		}
		
	}
}