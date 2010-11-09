package com.robinkruyt.Ypsilon
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		
		public function MenuState()
		{
			super();
		}
		
		override public function create():void
		{
			//Achtergrond
			FlxState.bgColor = 0xFFBAE2FF;		
			
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Ypsilon");
			title.setFormat (null, 16, 0xFF000000, "center");
			add(title);
	
			var introText:FlxText;
			introText = new FlxText(0, 64, FlxG.width, "Well hello there Absaloth!\nYou know the drill: \nX for jumping.\nArrows for walking.\n 1-5 for inventory. The rest is is up to your mouse.");
			introText.setFormat (null, 8, 0xFF000000, "center");
			add(introText);		
			
			var instructions:FlxText
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Press X to start the game.");
			instructions.setFormat (null, 8, 0xFF000000, "center");
			add(instructions);
		}
		
		override public function update():void
		{
			if (FlxG.keys.X)
			{
				FlxG.flash.start(0xffffffff, 0.75);
				FlxG.fade.start(0xff000000, 1, function():void{ FlxG.state = new PlayState(); });
			}
			
			super.update();
		}
		
	}
}