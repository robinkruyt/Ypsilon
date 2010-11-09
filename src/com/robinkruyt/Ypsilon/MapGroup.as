package com.robinkruyt.Ypsilon
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	
	import org.flixel.*;
	
	public class MapGroup extends FlxGroup
	{
		public function MapGroup()
		{
			super();
		}
		
		//INSERT CHUNK X AND Y
		public function getObjectByLocation(X:int, Y:int):FlxObject
		{
			var r:FlxObject = null;
			var i:uint = 0;
			var o:FlxObject;
			var ml:uint = members.length;
			while(i < ml)
			{
				o = members[i++] as FlxObject;
				if(o != null)
				{
					if(o.x == X && o.y == Y)
						r = o;
				}
			}
			return r;
		}
		
	}
}