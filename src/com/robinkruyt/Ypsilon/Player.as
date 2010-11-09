package com.robinkruyt.Ypsilon
{
	import com.robinkruyt.Ypsilon.menu.*;
	
	import flash.geom.Point;
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source='assets/sprites/player.png')]
		private var ImgPlayer:Class;
		
		private var _moveSpeed:int = 400;
		private var _jumpPower:int = 800;
		private var _attackCounter:int = 0;
		private var counter:int = 0;
		
		private var _inventory:Array = new Array();
		
		public function Player(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(ImgPlayer, true, true, 16, 16); 
			
			//Physics
			maxVelocity.x = 200;
			maxVelocity.y = 200;
			
			//DEBUG
			if(!FlxG.debug)
			{
				acceleration.y = 420;  
			}
			       
			drag.x = 300;
			
			//Bounding box tweaks
			width = 8;
			height = 14;
			offset.x = 4;
			offset.y = 2;
			
			//Animations
			addAnimation("still", [0], 10);
			addAnimation("jump", [3]);
			addAnimation("run", [1,2],10);
			
			//Camera
			FlxG.follow(this,2.5);
			FlxG.followAdjust(0.5, 0.5);
			
		}
		
		override public function update():void
		{
			//Collisions updaten
			counter++
			if(counter >=1)
			{
				FlxU.setWorldBounds(x,y);
				counter = 0;
			}
			
			if(FlxG.mouse.pressed() && _attackCounter <= 0)
			{
				_attackCounter = 1;
				
				var chunkPos:FlxPoint = MapController.getCoordinates(FlxG.mouse.x, FlxG.mouse.y).relChunk
				var o:Map = PlayState.lyrBlocks.getObjectByLocation(chunkPos.x, chunkPos.y) as Map;
				var position:FlxPoint = MapController.getCoordinates(FlxG.mouse.x, FlxG.mouse.y).relBlock;
				
				
				switch(Menu.selected)
				{
					case 0:
						
						break;
					case 1:
						if(o.getTile(position.x,position.y) != 0)
						{
							o.setTile(position.x,position.y,0);
						}
						break;
					case 2:
					case 3:
					case 4:
						if(o.getTile(position.x,position.y) == 0)
						{
							o.setTile(position.x,position.y,Menu.selected-1); // Toolset met blocks corrigeren
						}
						break;
				}
			}  
			
			//Movement
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				velocity.x -= _moveSpeed * FlxG.elapsed;
			}
			else if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				velocity.x += _moveSpeed * FlxG.elapsed;
			}
			
			//DEBUG
			if(FlxG.debug)
			{
				if (FlxG.keys.DOWN)
				{
					facing = DOWN;
					velocity.y += _moveSpeed * FlxG.elapsed;
				}
				else if (FlxG.keys.UP)
				{
					facing = UP;
					velocity.y -= _moveSpeed * FlxG.elapsed;
				}
			}//END OF DEBUG
			
			if (FlxG.keys.justPressed("X") && velocity.y == 0)
			{
				velocity.y = -_jumpPower;
			}
			
			
			//Animations
			if (_attackCounter > 0)
			{
				_attackCounter -= FlxG.elapsed*3;
			}
			
			if (velocity.y != 0)
			{
				play("jump");
			}
			else
			{
				if (velocity.x == 0)
				{
					play("still");
				}
				else
				{
					play("run");
				}
				
			}
			
			super.update();
			
			
		}
	}
}