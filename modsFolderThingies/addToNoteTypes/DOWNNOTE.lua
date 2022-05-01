function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'DOWNNOTE' then --Check if the note on the chart is a Bullet Note
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'DOWNNOTE_assets'); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has penalties
			end

			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.hue', 0)
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', 0)
			setPropertyFromGroup('unspawnNotes', i, 'colorSwap.saturation', 0)
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'DOWNNOTE' then
		characterPlayAnim('boyfriend', 'hurt', true);
		setProperty('boyfriend.specialAnim', true);
	
		if getPropertyFromClass('ClientPrefs', 'downScroll') then
			setPropertyFromClass("ClientPrefs", "downScroll", false)
			setProperty("healthBar.y", screenHeight * 0.89)
			setProperty("scoreTxt.y", screenHeight * 0.89 + 36)
			setProperty("strumLine.y", 50)
			setProperty("timeTxt.y", 20)
			setProperty('timeBar.y', 20 + getProperty('timeTxt.height') / 4)

			for i = 1, 3 do doTweenY("tweenicon"..i, "iconP"..i, screenHeight * 0.9 - (getProperty('iconP'..i..".height") / 2) ,0.25, 'quadOut') end

			for i = 0, 12 do noteTweenY("tween"..i, i, 50, 0.25, 'quadOut') end
		else
        	setPropertyFromClass("ClientPrefs", "downScroll", true)
        	setProperty("strumLine.y", screenHeight - 150)
        	setProperty("healthBar.y", 54)
        	setProperty("scoreTxt.y", 94)
			setProperty("timeTxt.y", screenHeight - 45)
        	setProperty('timeBar.y', screenHeight - 45 + getProperty('timeTxt.height') / 4)

        	for i = 1, 3 do doTweenY("tweenicon"..i.."down", "iconP"..i, 50 - (getProperty('iconP'..i..".height") / 2) ,0.25, 'quadOut') end

        	for i = 0, 12 do noteTweenY("tween"..i.."down", i, getProperty('strumLine.y'), 0.25, 'quadOut') end
		end
	end
end