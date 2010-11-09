package com.robinkruyt.Ypsilon.menu
{
	import org.flixel.*;
	
	public class Menu extends FlxGroup
	{
		/*
			0	=	niks
			1	=	pick
			2	=	zand
			3	=	gras
			4	=	steen
		*/
		private static var _slots:Array = new Array(1,2,0,0,0);
		private static var _selected:int = 0;

		
		public function Menu()
		{
			super();

			for(var i:int = 0; i<_slots.length;i++)
			{
				var slot:MenuItem = new MenuItem(160+(i*21),10,_slots[i]);
				add(slot);
				
			}
			
		}

		public static function get selected():int
		{
			return _slots[_selected-1]; // -1 is om de array te corrigeren
		}

		public static function set selected(value:int):void
		{
			_selected = value;
		}

		public override function update():void{
			super.update();
			
			if(FlxG.keys.ONE)		{ _selected = 1; }
			else if(FlxG.keys.TWO)	{ _selected = 2; }
			else if(FlxG.keys.THREE){ _selected = 3; }
			else if(FlxG.keys.FOUR)	{ _selected = 4; }
			else if(FlxG.keys.FIVE)	{ _selected = 5; }
			
			
		}
		
	}
}