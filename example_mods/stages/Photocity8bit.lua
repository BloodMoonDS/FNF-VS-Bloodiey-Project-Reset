function onCreate()
	makeLuaSprite('Sky','stages/PhotocityNES/Sky', -600, -300);
	makeLuaSprite('CityBack','stages/PhotocityNES/Bg', -600, -300);
	makeLuaSprite('BuildingBack','stages/PhotocityNES/Bgbuilding', -600, -300);
	makeLuaSprite('buildingCelling','stages/PhotocityNES/backgroundFloor', -600, -300);
	if not lowQuality then -- if the game is not in low graphics mode
		setScrollFactor('BuildingBack', 0.9, 0.9);
		scaleObject('BuildingBack', 1.1, 1.1);
		setScrollFactor('CityBack', 0.7, 0.7);
		scaleObject('CityBack', 0.4, 0.4);
		setScrollFactor('Sky', 1, 1);
		addLuaSprite('Sky',false);
		addLuaSprite('CityBack',false);
		addLuaSprite('BuildingBack',false);
		addLuaSprite('buildingCelling',false);
	else	-- optimized code for a toaster	
		makeLuaSprite('optimizedImage','stages/PhotocityNES/Optimal', -600, -300);
		addLuaSprite('optimizedImage',false);
	end

	close(true);
end

function onBeatHit()


end
function onStepHit()



end

function onUpdate()



end