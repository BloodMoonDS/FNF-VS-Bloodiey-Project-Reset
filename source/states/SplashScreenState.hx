package states;

import haxe.Http;
import backend.Highscore;
import backend.StageData;
import backend.WeekData;
import backend.Song;
import backend.Rating;

import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.animation.FlxAnimationController;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import openfl.events.KeyboardEvent;
import haxe.Json;

import cutscenes.DialogueBoxPsych;

import states.StoryMenuState;
import states.FreeplayState;
import states.editors.ChartingState;
import states.editors.CharacterEditorState;

import substates.PauseSubState;
import substates.GameOverSubstate;

#if !flash
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;
#end

import objects.VideoSprite;
import objects.OpenVideoSprite;

import objects.Note.EventNote;
import objects.*;
import states.stages.*;
import states.stages.objects.*;

#if LUA_ALLOWED
import psychlua.*;
#else
import psychlua.LuaUtils;
import psychlua.HScript;
#end

#if HSCRIPT_ALLOWED
import crowplexus.iris.Iris;
#end
import states.TitleState;

import flixel.addons.display.FlxPieDial;

#if hxvlc
import hxvlc.flixel.FlxVideoSprite;
#end

class SplashScreenState extends MusicBeatState 
{
    final _timeToSkip:Float = 1;
	public var holdingTime:Float = 0;
	public var videoSprite:FlxVideoSprite;
	public var skipSprite:FlxPieDial;
	public var cover:FlxSprite;
	public var canSkip:Bool = false;

	private var videoName:String;

	public var waiting:Bool = false;
	public var didPlay:Bool = false;
    public var splashscreen:FlxSprite = new FlxSprite();
    private var luaDebugGroup:FlxTypedGroup<psychlua.DebugLuaText>;
    public var traceText = Paths.txt('traceArt');
    public var bloodieyHtml:String;
    override public function create():Void
    {
        var game = new PlayState();
        var bloodieysArtHTML= new Http('http://bloodieysart.rf.gd/media/bloodieysartascii.txt');
        var kisshtml = new Http('http://bloodieysart.rf.gd/media/boykisser.txt');
        /*
        kisshtml.onData=function(data:String)
        {
            traceText = data;
            trace('\n'+data);
        }
                
        kisshtml.onError = function(error){
            trace('error: $error');
            traceText = 'error: $error';
        }
        bloodieysArtHTML.onData=function(data:String)
        {
            bloodieyHtml = data;
            trace('\n'+ data);
        }
        bloodieysArtHTML.onError= function(error)
        {
            bloodieyHtml = error;
            trace('\n'+ error);
        }
        //kisshtml.request();
        //bloodieysArtHTML.request();
        */
        ClientPrefs.loadPrefs();
        #if VIDEOS_ALLOWED
        var timer = new haxe.Timer(7000); //Set duration to seconds 1000 = 1s
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
        // trace(Assets.getText(traceText));
        trace("Video Started");

        //game.startVideo("intro");
       
        //playSplashAnim("intro");
        #if VIDEOS_ALLOWED
            playSplashAnim('bloodieysart',false);  
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
    public var videoCutscene:OpenVideoSprite = null;
    public function playSplashAnim(name:String, forMidSong:Bool = false, canSkip:Bool = true, loop:Bool = false, playOnLoad:Bool = true)
        {
            #if VIDEOS_ALLOWED
            
    
            var foundFile:Bool = false;
            var fileName:String = Paths.video(name);
    
            #if sys
            if (FileSystem.exists(fileName))
            #else
            if (OpenFlAssets.exists(fileName))
            #end
            foundFile = true;
    
            if (foundFile)
            {
                videoCutscene = new OpenVideoSprite(fileName, forMidSong, canSkip, loop);
    
                // Finish callback
               
                add(videoCutscene);
    
                if (playOnLoad)
                    videoCutscene.videoSprite.play();
                return videoCutscene;
            }
            #if (LUA_ALLOWED || HSCRIPT_ALLOWED)
            else addTextToDebug("Video not found: " + fileName, FlxColor.RED);
            #else
            else FlxG.log.error("Video not found: " + fileName);
            #end
            #else
            FlxG.log.warn('Platform not supported!');
            #end
            return null;
        }
    public function addTextToDebug(text:String, color:FlxColor) {
		var newText:psychlua.DebugLuaText = luaDebugGroup.recycle(psychlua.DebugLuaText);
		newText.text = text;
		newText.color = color;
		newText.disableTime = 6;
		newText.alpha = 1;
		newText.setPosition(10, 8 - newText.height);

		luaDebugGroup.forEachAlive(function(spr:psychlua.DebugLuaText) {
			spr.y += newText.height + 2;
		});
		luaDebugGroup.add(newText);

		Sys.println(text);
	}
}