package com.robinkruyt.Ypsilon.menu
{
	import org.flixel.*;
	
	public class Menu extends FlxGroup
	{
		/*
			0	=	selector
			1	=	niks
			2	=	pick
			3	=	zand
			4	=	gras
			5	=	steen
		*/
		private static var _slots:Array = new Array({id:2, amount:1},{id:3, amount:1},{id:4, amount:1},{id:5, amount:1},{id:1, amount:1});
		private static var _selected:int = 1;
		
		private static var selector:MenuItem = new MenuItem(160,10,0);

		
		public function Menu()
		{
			super();

			for(var i:int = 0; i<_slots.length;i++)
			{
				var slot:MenuItem = new MenuItem(160+(i*21),10,_slots[i].id);
				add(slot);
			}
			
			add(selector);
			
		}

		public static function get selected():int
		{
			return _slots[_selected-1].id; // -1 is om de array te corrigeren
		}

		public static function set selected(value:int):void
		{
			_selected = value;
			selector.x = 160+((_selected-1)*21);
		}

		public override function update():void{
			super.update();
			
			if(FlxG.keys.ONE)		{ selected = 1; }
			else if(FlxG.keys.TWO)	{ selected = 2; }
			else if(FlxG.keys.THREE){ selected = 3; }
			else if(FlxG.keys.FOUR)	{ selected = 4; }
			else if(FlxG.keys.FIVE)	{ selected = 5; }
			
			
		}
		
	}
}