package states.stages;

import flixel.math.FlxRandom;
import states.stages.objects.*;
import cutscenes.CutsceneHandler;
import substates.GameOverSubstate;
import objects.Character;
import cutscenes.DialogueBoxPsych;
import states.PlayState;

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
	var latambgbad:BGSprite;
	var latambgFocus:BGSprite;
	var latambgFocusBad:BGSprite;
	override function create()
	{
		
		var latambg:BGSprite = new BGSprite('residencial', -600, -300, 1, 1);
		add(latambg);
		latambgbad = new BGSprite('residencial_bad',-600,-300,1,1);
		latambgbad.alpha = 0;
		add(latambgbad);
		latambgFocus = new BGSprite('residencial_focus',-600,-300,1,1);
		latambgFocus.alpha = 0;
		add(latambgFocus);
		if(!ClientPrefs.data.lowQuality) {
			floatingcube = new BGSprite('floatingcube',1000,250,1,1, ['cube idle'], true);
			floatingcube.updateHitbox();
			add(floatingcube);
			floatingcube2 = new BGSprite('floatingcube',10,250,1,1, ['cube idle'], true);
			floatingcube2.updateHitbox();
			add(floatingcube2);
			floatingcube.alpha = 0;
			floatingcube2.alpha = 0;
		}
		switch (songName)
		{
			default:
				FlxG.sound.playMusic(Paths.music('opal'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}
		if(isStoryMode && !seenCutscene)
		{
			
			
			
		}
		

		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
	}

	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case 'Power Cubes Alpha':
				var valor1 = Std.parseFloat(value1);
				var valor2 = Std.parseFloat(value2);
				
				var timer = new haxe.Timer(valor1*1000);
				if(!ClientPrefs.data.lowQuality){
				FlxTween.tween(floatingcube,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
				FlxTween.tween(floatingcube2,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
				}
				FlxTween.tween(latambgbad,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
				
			case 'LatamCity Focus':
				var valor1 = Std.parseFloat(value1);
				var valor2 = Std.parseFloat(value2);
				FlxTween.tween(latambgFocus,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
		}
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

	function latamCityIntro()
	{
		
		
		
		
	}
	// For events
}