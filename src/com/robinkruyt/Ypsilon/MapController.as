package com.robinkruyt.Ypsilon
{
	import org.flixel.*;
	
	public class MapController
	{
		
		public static const mapSize:FlxPoint	= new FlxPoint(100,100);
		public static const BLOCKSIZE:uint		= 16;
		public static const AMOUNTBLOCKS:int	= 3; // 0 based
		public static const AIRBLOCKS:int		= 2; // Amount of blocks to convert to air (There is more air than blocks in the world)
		
		public function MapController()
		{
		}
		
		public static function getCoordinates(X:int,Y:int):Object{
			
			var coordinates:Object = new Object();
			coordinates.block = new FlxPoint(Math.floor(X/16), Math.floor(Y/16)); // Position of underlying block
			coordinates.chunk = new FlxPoint(Math.floor(coordinates.block.x/mapSize.x), Math.floor(coordinates.block.y/mapSize.y)); // Position of underlying Tilemap
			coordinates.relChunk = new FlxPoint(coordinates.chunk.x * mapSize.x * BLOCKSIZE,coordinates.chunk.y * mapSize.y * BLOCKSIZE); // Chunks X and Y in gameCoordinates
			coordinates.sector = new FlxPoint(Math.floor(((coordinates.block.x-(coordinates.chunk.x*mapSize.x))*3)/mapSize.x), Math.floor(((coordinates.block.y-(coordinates.chunk.y*mapSize.y))*3)/mapSize.y));
			coordinates.relBlock = new FlxPoint(Math.floor(coordinates.block.x-(coordinates.chunk.x*mapSize.x)), Math.floor(coordinates.block.y-(coordinates.chunk.y*mapSize.y))); // Position of underlying block relative to the chunk
			
			return coordinates;
		}
	}
}