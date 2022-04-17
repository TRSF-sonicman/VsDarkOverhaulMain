package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class CodeState extends MusicBeatState
{
    var epicText:FlxText;
    var code:FlxText;

    override function create()
    {
        FlxG.sound.music.volume = 0;

        epicText = new FlxText(0,0,0,"More awaits inside of the main menu screen :)",15);
        epicText.screenCenter();
        add(epicText);

        code = new FlxText(epicText.x,epicText.y + 50,0,"DARK",30);
        add(code);

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