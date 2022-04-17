package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;

class ThanksForPlayingState extends MusicBeatState
{
    var epicImage:FlxSprite;

    override function create()
    {
        FlxG.sound.music.volume = 0;

        epicImage = new FlxSprite(0,0).loadGraphic(Paths.image('ThanksForPlayingImage'));
        epicImage.screenCenter();
        add(epicImage);

        FlxG.sound.play(Paths.sound('thanksforplaying'));

        super.create();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        new FlxTimer().start(8, function(tmr:FlxTimer) {
            LoadingState.loadAndSwitchState(new TitleState());
        });
    }
}