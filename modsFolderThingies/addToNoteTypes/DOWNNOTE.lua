function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'DOWNNOTE' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'DOWNNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0); --custom notesplash color, why not
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', -20);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', 1);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has penalties
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'DOWNNOTE' then
	characterPlayAnim('boyfriend', 'hurt', true);
	setProperty('boyfriend.specialAnim', true);
	
	if getPropertyFromClass('ClientPrefs', 'downScroll') then
		setPropertyFromClass("ClientPrefs", "downScroll", false)
		doTweenY("tween10", "healthBar", screenHeight * 0.89 ,0.25, 'quadOut')
		doTweenY("tween11down", "scoreTxt", screenHeight * 0.89 + 36, 0.25, "quadOut")
		setProperty("strumLine.y", 50)
		doTweenY("tween8", 'timeTxt', 20 ,0.25, 'quadOut')
		setProperty("timeTxt.y", 20)
		doTweenY("tween9", 'timeBar', 20 + getProperty('timeTxt.height') / 4,0.25, 'quadOut')

		for i = 1, 2 do doTweenY("tweenicon"..i, "iconP"..i, screenHeight * 0.9 - (getProperty('iconP'..i..".height") / 2) ,0.25, 'quadOut') end

		for i = 0, 8 do noteTweenY("tween"..i, i, 50, 0.25, 'quadOut') end
	else
        	setPropertyFromClass("ClientPrefs", "downScroll", true)

        	setProperty("strumLine.y", screenHeight - 150)

        	doTweenY("tween10down", "healthBar", 54 ,0.25, 'quadOut')
        	doTweenY("tween11down", "scoreTxt", 94, 0.25, "quadOut")

			setProperty("timeTxt.y", screenHeight - 45)
        	doTweenY("tween9down", 'timeBar', screenHeight - 45 + getProperty('timeTxt.height') / 4,0.25, 'quadOut')

        	for i = 1, 2 do doTweenY("tweenicon"..i.."down", "iconP"..i, 50 - (getProperty('iconP'..i..".height") / 2) ,0.25, 'quadOut') end

        	for i = 0, 8 do noteTweenY("tween"..i.."down", i, getProperty('strumLine.y'), 0.25, 'quadOut') end
	end
	end
end