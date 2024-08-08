package states;


import backend.WeekData;
import backend.Highscore;

import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import shaders.ColorSwap;

import states.StoryMenuState;
import states.OutdatedState;
import states.MainMenuState;

class SplashScreenState extends MusicBeatState 
{
    public var splashscreen:FlxSprite = new FlxSprite();
    override public function create():Void
    {
        
        var timer = new haxe.Timer(5000);
        var haddone = 0;
        splashscreen.loadGraphic(Paths.image("bloodieysart"));
        add(splashscreen);
        splashscreen.alpha = 1;
        splashscreen.scale.x = 1;
        splashscreen.scale.y = 1;

        splashscreen.x = 128+32;
        splashscreen.y = 320-32;

        super.create();
        trace("Doing Tween");
        FlxG.sound.play(Paths.sound("bloodieysart"));
        FlxTween.tween(splashscreen,{"scale.x": splashscreen.scale.x*1, "scale.y": splashscreen.scale.y*1, "alpha": 1 } ,1,{ease: FlxEase.circIn, type: ONESHOT, onComplete: section3()  });
        
        timer.run = function() 
        {
            if(haddone == 0)
            {
                haddone = 1;
                MusicBeatState.switchState(new TitleState());
            }
        }
        
    }
    function section2():TweenCallback
    {
        trace("section2");
        FlxTween.tween(splashscreen,{"scale.x": splashscreen.scale.x*1, "scale.y": splashscreen.scale.y*1, "alpha": 1  } ,1,{ease: FlxEase.linear, type: ONESHOT, onComplete: section3()  });
        return null;
    }
    function section3():TweenCallback
    {
        trace("section3");
        FlxTween.tween(splashscreen,{"scale.x": splashscreen.scale.x/2, "scale.y": splashscreen.scale.y/2, "alpha": 0 } ,4,{ease: FlxEase.circIn, type: ONESHOT, onComplete: getbacktoTitle()});
        return null;
    }
    public function getbacktoTitle():TweenCallback
    {
        // MusicBeatState.switchState(new TitleState());
        return null;
    }

    public function playSplashAnim():Void 
    {
        
    }

}