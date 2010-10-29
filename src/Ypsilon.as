package
{
	import com.robinkruyt.Ypsilon.MenuState;
	
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="640", height="480", backgroundColor="#FFFFFF")] //Set the size and color of the Flash file
	[Frame(factoryClass="com.robinkruyt.Ypsilon.Preloader")] //Tells Flixel to use the default preloader
	
	public class Ypsilon extends FlxGame
	{
		[Embed(source="assets/music/BareBones.mp3")] private var BareBones:Class; //Music
		
		public function Ypsilon()
		{	
			super(320,240,MenuState,2); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			FlxG.playMusic(BareBones);
			
			FlxG.debug = false;
		}
		
	}
}