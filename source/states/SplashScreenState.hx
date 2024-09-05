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

import states.PlayState;
import states.StoryMenuState;
import states.OutdatedState;
import states.MainMenuState;

#if !flash
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;
#end

#if VIDEOS_ALLOWED
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end
#end

class SplashScreenState extends MusicBeatState 
{
    public var splashscreen:FlxSprite = new FlxSprite();
    override public function create():Void
    {
        var game = new PlayState();

        ClientPrefs.loadPrefs();
        #if VIDEOS_ALLOWED
        var timer = new haxe.Timer(10000);
        #else
        var timer = new haxe.Timer(5000);
        #end
        var haddone = 0;
        splashscreen.loadGraphic(Paths.image("bloodieysart"));
        add(splashscreen);
        splashscreen.alpha = 1;
        splashscreen.scale.x = 1;
        splashscreen.scale.y = 1;

        splashscreen.x = 128+32;
        splashscreen.y = 320-32;

        super.create();

        trace("Video Started");

        //game.startVideo("intro");
        #if VIDEOS_ALLOWED
        playSplashAnim("intro");
        #else
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
        #end
        
        trace("Video ended");
        
        timer.run = function() 
         {
            if(haddone == 0)
            {
                haddone = 1;
                MusicBeatState.switchState(new TitleState());
            }
        }
        /*
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
        */
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

    public function playSplashAnim(name:String):Void 
    {
        #if VIDEOS_ALLOWED
		

		var filepath:String = Paths.video(name);
		#if sys
		if(!FileSystem.exists(filepath))
		#else
		if(!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + name);
			
			return;
		}

		var video:VideoHandler = new VideoHandler();
			#if (hxCodec >= "3.0.0")
			// Recent versions
			video.play(filepath);
			video.onEndReached.add(function()
			{
				video.dispose();
				
				return;
			}, true);
			#else
			// Older versions
			video.playVideo(filepath);
			video.finishCallback = function()
			{
				
				return;
			}
			#end
		#else
		FlxG.log.warn('Platform not supported!');
		startAndEnd();
		return;
		#end
    }

}