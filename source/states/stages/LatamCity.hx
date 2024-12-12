package states.stages;

import flixel.math.FlxRandom;
import states.stages.objects.*;
import cutscenes.CutsceneHandler;
import substates.GameOverSubstate;
import objects.Character;

class LatamCity extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

    
	function createRandomCubes():Void
	{
		var CurCubes = 0;
		var floatingcube:BGSprite;
		while(CurCubes < 20)
		{
			var randomselector = new FlxRandom();
			var randomposx = randomselector.float(dad.x -200,dad.x +200);
			var randomposy = randomselector.float(dad.y -200,dad.y +200);


			var cube:FlxAnimate;
			floatingcube = new BGSprite('floatingcube',randomposx,randomposy,1,1, ['cube idle'], true);
			floatingcube.updateHitbox();
			add(floatingcube);
			CurCubes + 1;
		}
	}

	var cube:FlxAnimate;
	var floatingcube:BGSprite;
	var floatingcube2:BGSprite;
	override function create()
	{
		
		var latambg:BGSprite = new BGSprite('residencial', -600, -300, 1, 1);
		add(latambg);
		
		if(!ClientPrefs.data.lowQuality) {
			//createRandomCubes(); 
			/*
			cube = new FlxAnimate(25, 25);
			cube.showPivot = false;
			Paths.loadAnimateAtlas(cube,'stage/LatamCity/floatingcube');
			cube.anim.addBySymbol('cube_idle','cube idle');
			cube.anim.play('cube_idle',true);
			*/ //this shit doesnt work
			var CurCubes = 0;
			
			

			floatingcube = new BGSprite('floatingcube',1000,250,1,1, ['cube idle'], true);
			floatingcube.updateHitbox();
			add(floatingcube);
			floatingcube2 = new BGSprite('floatingcube',10,250,1,1, ['cube idle'], true);
			floatingcube2.updateHitbox();
			add(floatingcube2);

		}

		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
	}
	override function beatHit()
	{
		// Code here
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
}