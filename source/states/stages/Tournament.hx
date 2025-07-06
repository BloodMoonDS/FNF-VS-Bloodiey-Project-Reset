package states.stages;

import flixel.math.FlxRandom;
import states.stages.objects.*;
import cutscenes.CutsceneHandler;
import substates.GameOverSubstate;
import objects.Character;
import objects.Note;

class Tournament extends BaseStage
{
	// If you're moving your stage from PlayState to a stage file,
	// you might have to rename some variables if they're missing, for example: camZooming -> game.camZooming

	var tournamentBG:BGSprite;
	var karma:BGSprite;
	var fanta:BGSprite;
	var pipol:BGSprite;
	var tournamentbgblue:BGSprite;
	var tournamentbgcolor:BGSprite;
	var Geometry1:BGSprite;
	var Geometry2:BGSprite;
	override function create()
	{
		var _song = PlayState.SONG;
		if(_song.gameOverSound == null || _song.gameOverSound.trim().length < 1) GameOverSubstate.deathSoundName = 'GameOverBeginBloodiey';
		if(_song.gameOverLoop == null || _song.gameOverLoop.trim().length < 1) GameOverSubstate.loopSoundName = 'gameOverBloodiey';
		if(_song.gameOverEnd == null || _song.gameOverEnd.trim().length < 1) GameOverSubstate.endSoundName = 'bloodieysart';
		// Spawn your stage sprites here.
		// Characters are not ready yet on this function, so you can't add things above them yet.
		// Use createPost() if that's what you want to do.
		tournamentbgblue = new BGSprite('tournamentblue',-500,-300,1.2,1.2);
		tournamentbgblue.alpha = 0;
		tournamentBG = new BGSprite('tournament',-500,-300,1.2,1.2);
		tournamentbgcolor = new BGSprite('tournamentcolorswitch',-500,-300,1.2,1.2);
		tournamentbgcolor.alpha = 0;
		add(tournamentBG);
		add(tournamentbgblue);
		add(tournamentbgcolor);
		

		
		if(!ClientPrefs.data.lowQuality)
		{
			pipol = new BGSprite('Tournament/People',200,300,1,1,['Símbolo 1 instancia 1'],true);
			add(pipol);
		}
		karma = new BGSprite('Tournament/Karma',-100,250,1,1,['Karma'],false);
		add(karma);	
		fanta = new BGSprite('Tournament/Fantasmal_Invert',1400,350,1,1,['Fantaasmal_Twisted'],false);
		add(fanta);
		if(!ClientPrefs.data.lowQuality)
		{
			Geometry1 = new BGSprite('Tournament/geometry',-100,0,1,1,['geometry idle'],true);
			Geometry1.alpha = 0;
			add(Geometry1);
			Geometry2 = new BGSprite('Tournament/geometry',1400,0,1,1,['geometry idle'],true);
			Geometry2.alpha = 0;
			add(Geometry2);
		}
	}
	public function karmaandfantadance()
	{
		karma.dance();
		fanta.dance();
	}
	
	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	override function destroy()
	{
		// Code here
	}

	
	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
				karmaandfantadance();
			case TWO: //num 1
				karmaandfantadance();
			case ONE: //num 2
				karmaandfantadance();
			case GO: //num 3
				karmaandfantadance();
			case START: //num 4
				karmaandfantadance();
		}
	}

	override function startSong()
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
		karmaandfantadance();
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
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "Tournament Color Twist":
				var valor1 = Std.parseFloat(value1);
				var valor2 = Std.parseFloat(value2);				
				FlxTween.tween(tournamentbgcolor,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
			case "Tournament Geometrical Chaos":
				var valor1 = Std.parseFloat(value1);
				var valor2 = Std.parseFloat(value2);

				var timer = new haxe.Timer(valor1*1000);
				if(!ClientPrefs.data.lowQuality){
				FlxTween.tween(Geometry1,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
				FlxTween.tween(Geometry2,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});
				}
				FlxTween.tween(tournamentbgblue,{'alpha': valor2},valor1,{ease: FlxEase.circIn, type: ONESHOT});

		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}

	// Note Hit/Miss
	override function goodNoteHit(note:Note)
	{
		// Code here
	}

	override function opponentNoteHit(note:Note)
	{
		// Code here
	}

	override function noteMiss(note:Note)
	{
		// Code here
	}

	override function noteMissPress(direction:Int)
	{
		// Code here
	}
}