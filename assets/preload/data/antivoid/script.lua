-- Script made by Catbrother Everything with help by NardBruh. Credit is not needed but would be nice! :)
-- Cautionary Quartet team here, yea, credits to Catbrother, we also changing this a bit for the offests, but most credits are for him.

function onCreate() 
	makeAnimatedLuaSprite('Dark', 'characters/dark_new', 0, 705); --add the spritesheet here, only the name, not the extension.
	addAnimationByPrefix('Dark', 'idle', 'idle', 24, false); -- Change to characters idle in XML
    addAnimationByPrefix('Dark', '0', 'left', 24, false); -- Change to characters leftnote in XML
    addAnimationByPrefix('Dark', '1', 'down', 24, false); -- Change to characters downnote in XML
    addAnimationByPrefix('Dark', '2', 'up', 24, false); -- Change to characters upnote in XML
    addAnimationByPrefix('Dark', '3', 'right', 24, false); -- Change to characters rightnote in XML
	objectPlayAnimation('Dark', 'idle'); 
	addLuaSprite('Dark', true); -- false = add behind characters, true = add over characters
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
		objectPlayAnimation('Dark', 'idle');
	end
end

lastNote = {0, ""}

function opponentNoteHit(id,d,t,s)

    lastNote[1] = d
    lastNote[2] = t
    
    if lastNote[2] == "No Animation"  then -- Change "No Animation" to be your note type, usually you can just keep it as no anim assuming you arent using it elsewhere
	objectPlayAnimation('Dark', lastNote[1]);
	else
		health = getProperty('health')
		cameraShake('game',0.01,0.1)
		if getProperty('health') > 0.05 then
			setProperty('health', health - 0.018)
		end
	end
end

function onUpdate(elapsed)
	if getProperty('Dark.animation.name') == 'idle' then
        setProperty('Dark.x', 0) --0
		setProperty('Dark.y', 705) --0
    end
	if getProperty('Dark.animation.name') == '0' then
        setProperty('Dark.x', -4) -- -4
		setProperty('Dark.y', 695) -- 10
    end
	if getProperty('Dark.animation.name') == '1' then
        setProperty('Dark.x', 0) -- 0
		setProperty('Dark.y', 712) -- -7
    end
	if getProperty('Dark.animation.name') == '2' then
        setProperty('Dark.x', -6) -- -6
		setProperty('Dark.y', 665) -- 40
    end
	if getProperty('Dark.animation.name') == '3' then
        setProperty('Dark.x', 0) -- 0
		setProperty('Dark.y', 685) -- 20
    end
end

local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'ohnoantidark');
	end
end