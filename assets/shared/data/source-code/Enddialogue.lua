function onEndSong()
	if not allowEnd and isStoryMode then
		--startVideo('testVideo');
		startDialogue('dialogueEnd', 'opal')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end