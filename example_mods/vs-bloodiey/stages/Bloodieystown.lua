function onCreate()
	-- background shit
	makeLuaSprite('town', 'stage/BloodieyTown', -400, -300);
	setScrollFactor('town', 1, 1);
	scaleObject('town', 1, 1);
	addLuaSprite('town', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end