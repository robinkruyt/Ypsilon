package com.robinkruyt.Ypsilon
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.flixel.*;
	import org.osmf.net.StreamingURLResource;
	
	public class Map extends FlxTilemap
	{
		[Embed(source = 'assets/sprites/blocks.png')] 
		private var ImgTiles:Class;
		
		private const mapSize:FlxPoint	= MapController.mapSize;
		private const BLOCKSIZE:uint	= MapController.BLOCKSIZE;
		private const AMOUNTBLOCKS:int	= MapController.AMOUNTBLOCKS; // 0 based
		private const AIRBLOCKS:int		= MapController.AIRBLOCKS; // Amount of blocks to convert to air (There is more air than blocks in the world)
		
		
		public function Map(X:int = 0, Y:int = 0)
		{
			super();
			x = X*(mapSize.x*BLOCKSIZE);
			y = Y*(mapSize.y*BLOCKSIZE);	
			
			PlayState.maps.push({x:X,y:Y,link:this});

			
			if(Y < 0) //Bovengronds
			{
				var mapStr:String = "";
				for(var X:int = 0; X < mapSize.x; X++)
				{
					for(var Y:int = 0; Y < mapSize.y; Y++)
					{
						mapStr += "0,";
					}
					mapStr += "\n";
				}
				
				loadMap(mapStr, ImgTiles,BLOCKSIZE);
			}else{
				loadMap(generateMap(), ImgTiles,BLOCKSIZE);
			}
			
		}
		
		public function generateMap():String
		{
			var w:int = mapSize.x*16; // Width of image
			var h:int = mapSize.y*16; // Height of image
			var g:int = 16; // size of 1 block
			
			var seed:int = Math.round(Math.random()*10);
			var channel:uint = 1;
			var bitmap:BitmapData = new BitmapData(w, h, true, 0xFF0000FF);
			bitmap.perlinNoise(w, h, 5, seed, true, false,  channel, true);
			
			
			var selectedPixel:Point = new Point();
			var heightMap:Array = new Array();
			var darkestPixel:Number = 1;
			var brightestPixel:Number = 0;
			
			
			var kolom:int	= 0;
			var rij:int		= 0;
			//First pass: Generate heightmap
			for( kolom = 0; kolom < mapSize.x; kolom++)
			{
				heightMap[kolom] = new Array();
				for( rij = 0; rij < mapSize.y; rij++)
				{
					selectedPixel.x = kolom*g;
					selectedPixel.y = rij*g;
					
					heightMap[kolom][rij] = bitmap.getPixel(selectedPixel.x,selectedPixel.y) / 0xFFFFFF;
					
					if (heightMap[kolom][rij] < darkestPixel) { darkestPixel = heightMap[kolom][rij]; }
					
				}
			}
			
			//Second pass: Set Darkest to 0;
			for( kolom = 0; kolom < mapSize.x; kolom++)
			{
				for( rij = 0; rij < mapSize.y; rij++)
				{
					heightMap[kolom][rij] -= darkestPixel;
					
					if (heightMap[kolom][rij] > brightestPixel) { brightestPixel = heightMap[kolom][rij]; }
				}
			}
			
			//Thirdh pass: Set Brightest to 1;
			for( kolom = 0; kolom < mapSize.x; kolom++)
			{
				for( rij = 0; rij < mapSize.y; rij++)
				{
					heightMap[kolom][rij] /= brightestPixel;
				}
			}
			//Fourth pass: Add air, Convert to CSV;
			var mapString:String = "";
			for( kolom = 0; kolom < mapSize.x; kolom++)
			{
				for( rij = 0; rij < mapSize.y; rij++)
				{
					var block:int = Math.round(heightMap[kolom][rij]*(AMOUNTBLOCKS+AIRBLOCKS));
					if(block > AMOUNTBLOCKS){block = 0;}
						
					mapString += block.toString() + ",";
				}
				mapString += "\n";
			}
			
			return mapString;
		}
		
		public override function update():void{
			super.update();
			
			if(onScreen())
			{
				visible = true;
			}else{
				visible = false;
			}
			
		}
		
		
		
	}
}