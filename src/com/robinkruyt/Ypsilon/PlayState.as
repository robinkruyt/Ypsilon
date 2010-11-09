package com.robinkruyt.Ypsilon
{
	import com.robinkruyt.Ypsilon.menu.Menu;
	
	import flash.geom.Point;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		/*		Layers				*/
		public static var lyrBackDrop:FlxGroup;	// Wolken
		public static var lyrSprites:FlxGroup;	// SPELER EN lyrBlocks
		public static var lyrBlocks:MapGroup;	// BLOKKEN
		public static var lyrHUD:FlxGroup;		// HUD
		
		/*		GameComponents		*/
		private var _player:Player;
		private var _sectors:Array;
		public static var maps:Array = new Array();
		private var menu:Menu = new Menu();
		
		
		public function PlayState()
		{
			super();
			FlxG.mouse.show();
		}
		
		public override function create():void
		{
			/*		Setup components		*/
			/*		Sectors					*/
			var map:Map = new Map(0,0);
			
			/*		Setup Layers		*/
			/*		Clouds				*/
			lyrBackDrop = new FlxGroup();
			for(var i:int = 0; i < 5; i++)
			{
				var cloud:Cloud = new Cloud(new FlxPoint(-200,0),new FlxPoint(0,200));
				lyrBackDrop.add(cloud);
				cloud.scrollFactor.x = cloud.scrollFactor.y = 0.2;
			}
			
			lyrSprites	= new FlxGroup();
			_player = new Player(50*16,-3*16);
			lyrSprites.add(_player);
			
			lyrBlocks	= new MapGroup();
			lyrBlocks.add(map);
			
			lyrHUD		= new FlxGroup();
			lyrHUD.add(menu);
			
			
			
			/*		Add Layers		*/
			add(lyrBackDrop);
			add(lyrSprites);
			lyrSprites.add(lyrBlocks);
			add(lyrHUD);
			
			
		}
		
		public override function update():void{
			super.update();
			
			if(FlxG.keys.I)
			{
				FlxG.pause = true;
			}
			
			/*		Collisions		*/
			if(!FlxG.debug)
			{
				FlxU.collide(lyrSprites,lyrSprites);
			}
			
			/*		New Chunks		*/
			
			var playerCoordinates:Object = MapController.getCoordinates(_player.x,_player.y);
				var chunkList:Array;
				/*		Links		*/
				if(playerCoordinates.sector.x == 0)
				{
					chunkList = maps.filter(function(element:*, index:int, arr:Array):Boolean{ return (element.x == playerCoordinates.chunk.x-1 && element.y == playerCoordinates.chunk.y ); });
					if(!chunkList[0])
					{
						lyrBlocks.add(new Map(playerCoordinates.chunk.x-1,playerCoordinates.chunk.y));
					}
					
				}
					/*		Rechts		*/
				else if(playerCoordinates.sector.x == 2)
					
				{
					chunkList = maps.filter(function(element:*, index:int, arr:Array):Boolean{ return (element.x == playerCoordinates.chunk.x+1 && element.y == playerCoordinates.chunk.y ); });
					
					if(!chunkList[0])
					{
						lyrBlocks.add(new Map(playerCoordinates.chunk.x+1,playerCoordinates.chunk.y));
					}
				}
				/*		Boven		*/
				if(playerCoordinates.sector.y == 0)
				{
					chunkList = maps.filter(function(element:*, index:int, arr:Array):Boolean{ return (element.x == playerCoordinates.chunk.x && element.y == playerCoordinates.chunk.y-1 ); });
										
					if(!chunkList[0])
					{
						lyrBlocks.add(new Map(playerCoordinates.chunk.x,playerCoordinates.chunk.y-1));
					}
					
				}
					/*		Onder		*/
				else if(playerCoordinates.sector.y == 2)
				{
					chunkList = maps.filter(function(element:*, index:int, arr:Array):Boolean{ return (element.x == playerCoordinates.chunk.x && element.y == playerCoordinates.chunk.y+1 ); });
					
					if(!chunkList[0])
					{
						lyrBlocks.add(new Map(playerCoordinates.chunk.x,playerCoordinates.chunk.y+1));
					}
				}
			
			
			
		}
	}
}