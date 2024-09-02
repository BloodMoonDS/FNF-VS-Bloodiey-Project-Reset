package states;

import backend.WeekData;
import backend.Mods;

import flixel.math.FlxRandom;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import sys.thread.Thread;
import webview.WebView;

import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;
import openfl.events.Event;

import sys.thread.Thread;
import flixel.ui.FlxButton;
import flixel.FlxBasic;
import flixel.graphics.FlxGraphic;
import flash.geom.Rectangle;
import lime.utils.Assets;
import haxe.Json;

import flixel.util.FlxSpriteUtil;
import objects.AttachedSprite;
import options.ModSettingsSubState;
import flixel.addons.transition.FlxTransitionableState;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLLoaderDataFormat;
import openfl.events.Event;
import haxe.io.Bytes;
import format.zip.Reader;
import haxe.io.BytesInput;
import sys.io.File;
import sys.io.FileOutput;
import sys.FileSystem;

//im giving up with this fucking shit 31/08/2024


class DlcMenuState extends MusicBeatState
{
	// Menu Shit
	public var DlcShit:Array<String> = [];
	public static var curSelected:Int = 0;

	private var head:FlxText;
	private var body:FlxText;
	private var spinning:FlxSprite;

	public var mytext:FlxText = new FlxText();
	public var DlcJson:Json;
	public var jsonString:String;
	public static var DlcDir:String = "https://raw.githubusercontent.com/BloodMoonDS/BloodMoonDS/main/assets/funkindlcs.json";
	public static var DlcStore:String = "https://bloodmoonds.github.io/vs-bloodiey-modstore/";
	private var html:String;

	var DlcHttp = new haxe.Http(DlcDir);
	var DlcStoreHttp = new haxe.Http(DlcStore);
	public var JsonDat:Json;
	public var EngineVer:String;

	override function create()
	{
		var menuBg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('aeroBG'));
		menuBg.antialiasing = ClientPrefs.data.antialiasing;
		menuBg.scrollFactor.set(0, 0);
		menuBg.setGraphicSize(Std.int(menuBg.width * 1.175));
		menuBg.updateHitbox();
		menuBg.screenCenter();
		add(menuBg);


		
		var ourText = new FlxText(0, 0, FlxG.width,
			"Don't Close That Window!!!. \n
			Here you can download all the DLCS.\n
			Unzipping in the 'Mods/' folder",
			32);
		add(ourText);


		DlcStoreHttp.onData = function (data:String)
		{
			trace('Got Data: $data');
			html = data;
				
		}
		DlcStoreHttp.onError = function (error)
		{
			trace('error: $error');
		}
		
		DlcHttp.onData = function (data:String)
		{
			trace('Got Data: $data');
			jsonString = data;
			DlcJson = Json.parse(data);
			
		}
		DlcHttp.onError = function (error)
		{
			trace('error: $error');
		}
		DlcStoreHttp.request();
		Thread.createWithEventLoop(() ->
		{
			var Viewer:WebView = new WebView(#if debug true #end);

			Viewer.setTitle("FNF Vs Bloodiey DLC portal");
			Viewer.setSize(960, 540, 0);
			Viewer.setHTML(html);
			Application.current.onExit.add((_) ->
			{
				Viewer.terminate();
				Viewer.destroy();
			});

			// Little note, you have to run the webview thread in order to work with binds and more stuff, basic operations like
			// navigating to a webpage should work without the need to create a thread
			// but if you want to manipulate variables from the main thread you will need to
			// create a thread and run the webview thread inside of it to avoid "Critical Error: Allocating from a GC-free thread"
			// also this approach isn't working correctly at all since it freezes after a couple of seconds

			Viewer.bind("callOnGame", (seq, req, arg) ->
			{
				var args:Array<String> = req.substring(1, req.length - 1).split(",");
				body.text = formatString(args[0]);

				Viewer.resolve(seq, 0, "");
			}, null);

			Viewer.run();
		});

		//add(spinning = new FlxSprite(0, 0).makeGraphic(100, 100, FlxColor.WHITE));
		//spinning.screenCenter();

		//add(head = new FlxText(50, 50, 0, "HaxeFlixel example", 32));
		//add(body = new FlxText(50, 125, 0, "Waiting for input...", 24));

		DlcHttp.request(); // you gotta be kidding

		
		

		super.create();
	}
	override function update(elapsed:Float)
	{
		if(controls.ACCEPT){
			trace(Json.stringify(DlcJson) );
		}
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		super.update(elapsed);

		
	}
	private function formatString(s:String):String
	{
		return s.substring(1, s.length - 1);
	}
}