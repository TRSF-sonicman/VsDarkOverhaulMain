
package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import lime.app.Application;
#if desktop
import Discord.DiscordClient;
#end
import openfl.display.BitmapData;
import openfl.utils.Assets;
import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if cpp
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class Cache extends MusicBeatState
{
	public static var bitmapData:Map<String,FlxGraphic>;
	public static var bitmapData2:Map<String,FlxGraphic>;

	var images = [];
	var music = [];

	var shitz:FlxText;

	override function create()
	{
		FlxG.mouse.visible = false;

		FlxG.worldBounds.set(0,0);

		bitmapData = new Map<String,FlxGraphic>();
		bitmapData2 = new Map<String,FlxGraphic>();

		var darkBG:FlxSprite = new FlxSprite(-5000, -615).loadGraphic(Paths.image('loadingShit/loading' + FlxG.random.int(1, 3)));
		darkBG.antialiasing = true;
		darkBG.screenCenter(X);
		darkBG.setGraphicSize(Std.int(darkBG.width * 0.43));
		add(darkBG);
		

		var darkSP:FlxSprite = new FlxSprite(-5000, -615).loadGraphic(Paths.image('loadingShit/loading4'));
		darkSP.antialiasing = true;
		darkSP.screenCenter(X);
		darkSP.setGraphicSize(Std.int(darkSP.width * 0.43));
		add(darkSP);
		darkSP.visible = false;

		if (FlxG.random.bool(10.1))
		{
			darkSP.visible =  true;
			darkBG.visible =  false;			
		}
		else
		{
			darkBG.visible = true;
			darkSP.visible = false;
		}

		shitz = new FlxText(12, 12, 0, "Loading...", 12);
		shitz.scrollFactor.set();
		shitz.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(shitz);

		#if cpp
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}

		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
		{
			music.push(i);
		}
		#end

		sys.thread.Thread.create(() -> {
			cache();
		});

		super.create();
	}

	override function update(elapsed) 
	{
		super.update(elapsed);
	}

	function cache()
	{
		#if !linux
			var sound1:FlxSound;
			sound1 = new FlxSound().loadEmbedded(Paths.voices('fresh'));
			sound1.play();
			sound1.volume = 0.00001;
			FlxG.sound.list.add(sound1);

			var sound2:FlxSound;
			sound2 = new FlxSound().loadEmbedded(Paths.inst('fresh'));
			sound2.play();
			sound2.volume = 0.00001;
			FlxG.sound.list.add(sound2);
		for (i in images)
		{
			var replaced = i.replace(".png","");
			var data:BitmapData = BitmapData.fromFile("assets/shared/images/characters/" + i);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced,graph);
			trace(i);
		}



		for (i in music)
		{
			trace(i);
			FlxG.sound.cache(Paths.inst(i));
			FlxG.sound.cache(Paths.voices(i));
		}


		#end
		FlxG.switchState(new TitleState());
	}

}