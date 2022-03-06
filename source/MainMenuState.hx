package;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.1'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var sex:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story',
		'freeplay',
		//#if MODS_ALLOWED 'mods', #end
		'credits',
		'options',
		//#if ACHIEVEMENTS_ALLOWED 'awards' #end
		//#if !switch 'donate', #end
		
	];
	var wallOptionShit:Array<String> = [
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'creds'
	];

	var debug:Bool = false;
	var sky:FlxSprite;
	var sidewalk:FlxSprite;
	var wall:FlxSprite;
	var graffiti:FlxSprite;
	var graffiti2:FlxSprite;
	var bench:FlxSprite;
	var dark:FlxSprite;
	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	var stepsFromExtras:Int;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		stepsFromExtras = 4;

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		sky = new FlxSprite(-80, 200).loadGraphic(Paths.image('darkmainui/sky'));
		sky.scrollFactor.set(0, yScroll);
		sky.screenCenter();
		sky.updateHitbox();
		add(sky);

		sidewalk = new FlxSprite(-144, 97).loadGraphic(Paths.image('darkmainui/sidewalk2'));
		sidewalk.scrollFactor.set(0, yScroll);
		sidewalk.updateHitbox();
		add(sidewalk);

		wall = new FlxSprite(585, -297).loadGraphic(Paths.image('darkmainui/wall'));
		wall.scrollFactor.set(0, yScroll);
		wall.updateHitbox();
		add(wall);

		bench = new FlxSprite(485, 167).loadGraphic(Paths.image('darkmainui/bench'));
		bench.scrollFactor.set(0, yScroll);
		bench.updateHitbox();
		
		graffiti = new FlxSprite(1050, 0).loadGraphic(Paths.image('darkmainui/trophy_graff'));
		graffiti.scrollFactor.set(0, yScroll);
		graffiti.updateHitbox();

		graffiti2 = new FlxSprite(615, 350).loadGraphic(Paths.image('darkmainui/credits_song_graff'));
		graffiti2.scrollFactor.set(0, yScroll);
		graffiti2.updateHitbox();
		
		dark = new FlxSprite(300, -97);
		dark.frames = Paths.getSparrowAtlas('darkmainui/MAIN_bop');
		dark.animation.addByPrefix('bop', 'bop', 24);
		dark.animation.play('bop');
		dark.scrollFactor.set(0, yScroll);
		dark.updateHitbox();

		if(dark != null) 
			dark.animation.play('bop', true);

<<<<<<< HEAD
<<<<<<< HEAD
		if(FlxG.save.data.weekCompleted = true)
		{
=======
		
		if(ClientPrefs.darkWeekBeaten == true) {
			FlxG.save.data.darkWeekBeaten = ClientPrefs.darkWeekBeaten;
>>>>>>> 27cb2790e4c11bef09c08b36dedc30b7284a3b70
=======
		
		if(ClientPrefs.darkWeekBeaten == true) {
			FlxG.save.data.darkWeekBeaten = ClientPrefs.darkWeekBeaten;
>>>>>>> 27cb2790e4c11bef09c08b36dedc30b7284a3b70
			FlxG.mouse.visible = true;
			add(graffiti);
			add(graffiti2);
		}
<<<<<<< HEAD
<<<<<<< HEAD
		else
		if(FlxG.save.data.weekCompleted = false)
		{
			FlxG.mouse.visible = false;
		}
			
=======

>>>>>>> 27cb2790e4c11bef09c08b36dedc30b7284a3b70
=======

>>>>>>> 27cb2790e4c11bef09c08b36dedc30b7284a3b70
		add(bench);
		add(dark);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/darkmenushit/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x += 80;
			//menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		//FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (FlxG.mouse.overlaps(graffiti) && FlxG.mouse.pressed)
			{
				MusicBeatState.switchState(new AchievementsMenuState());

			}
			if (FlxG.mouse.overlaps(graffiti2) && FlxG.mouse.pressed)
			{
                trace("boob");

                PlayState.SONG = Song.loadFromJson('roll-the-credits/roll-the-credits-hard');
                PlayState.isStoryMode = false;
                CoolUtil.difficultyString() == 'HARD';
                PlayState.storyWeek = 1;
                LoadingState.loadAndSwitchState(new PlayState());
			}
			
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}
		if (FlxG.keys.justPressed.DELETE)
		{
			var boob = 0;
			new FlxTimer().start(0.1, function(hello:FlxTimer)
			{
				boob += 1;
				if (boob == 30)
				{
					FlxG.save.data.weekCompleted = false;
					FlxG.switchState(new MainMenuState());
				}
				if (FlxG.keys.pressed.DELETE)
				{
					hello.reset();
				}
			});
		}
			if(FlxG.keys.justPressed.D) {
				stepsFromExtras = 3;
				trace("Three more steps");
			}

			if(FlxG.keys.justPressed.A && stepsFromExtras == 3) {
				stepsFromExtras = 2;
				trace("Two more steps");
			}

			if(FlxG.keys.justPressed.R && stepsFromExtras == 2) {
				stepsFromExtras = 1;
				trace("One more step");
			}

			if(FlxG.keys.justPressed.K && stepsFromExtras == 1) {
				stepsFromExtras = 0;
			}

			if(stepsFromExtras == 0) {
				if(ClientPrefs.extraOn == false) {
					ClientPrefs.extraOn = true;
					FlxG.save.data.extraOn = ClientPrefs.extraOn;
					FlxG.sound.play(Paths.sound('darkFuniVoice'));
					trace("Extra Songs Activated");
					stepsFromExtras = 4;
				} else {
					ClientPrefs.extraOn = false;
					FlxG.save.data.extraOn = ClientPrefs.extraOn;
					FlxG.sound.play(Paths.sound('darkFuniVoice'));
					trace("Extra Songs Desactivated");
					stepsFromExtras = 4;
				}
			}

			if (controls.ACCEPT)
			{
				//if (optionShit[curSelected] == 'donate')
				//{
				//	CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				//
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									//#if MODS_ALLOWED
									//case 'mods':
									//	MusicBeatState.switchState(new ModsMenuState());
									//#end
									//case 'awards':
										//MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										MusicBeatState.switchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
