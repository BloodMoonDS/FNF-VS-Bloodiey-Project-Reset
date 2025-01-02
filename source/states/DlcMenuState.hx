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
#if windows
import webview.WebView;
#end
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
import haxe.zip.Uncompress;
//im giving up with this fucking shit 31/08/2024


class DlcMenuState extends MusicBeatState
{
	// Menu Shit
	public var DlcShit:Array<String> = [];
	public static var curSelected:Int = 0;

	public var menuItems:FlxTypedGroup<FlxSprite>;
	private var head:FlxText;
	private var body:FlxText;
	private var spinning:FlxSprite;

	public var mytext:FlxText = new FlxText();
	public var DlcJson:Json;
	public var jsonString:String;
	public static var DlcDir:String = "https://raw.githubusercontent.com/BloodMoonDS/BloodMoonDS/main/assets/funkindlcs.json";
	public static var DlcStore:String = "https://raw.githubusercontent.com/BloodMoonDS/vs-bloodiey-modstore/refs/heads/main/docs/index.html";
	public static var VsBloodieyDlcList = "https://raw.githubusercontent.com/BloodMoonDS/BloodMoonDS/main/assets/funkindlclist.txt";
	public static var DlcStorXD:String = "https://bloodmoonds.github.io/vs-bloodiey-modstore/";
	private var html:String;

	var DlcHttp = new haxe.Http(VsBloodieyDlcList);
	var DlcStoreHttp = new haxe.Http(DlcStore);
	public var JsonDat:Json;
	public var EngineVer:String;

	public var dlcsaviable:String = null;
	var ThisArray:Array<String>;
	function SeparateTheDlcList(fulldata:String)
	{
		ThisArray = fulldata.split('\n');
		for(v in ThisArray)
		{
			var cosohttp = new haxe.Http("https://raw.githubusercontent.com/BloodMoonDS/BloodMoonDS/main/assets/data/"+v+".json");
			cosohttp.onData=function(data:String)
			{
				trace(data);
			}
			cosohttp.onError=function(error)
			{
				trace('Error: $error');
			}
			trace(v);
			cosohttp.request();
		}

	}
	function createDlcOption(dlcname:String, x:Float, y:Float):FlxSprite
	{
		trace(dlcname);
		var DlcData:Json;
		var DlcDataHttp = new haxe.Http("https://raw.githubusercontent.com/BloodMoonDS/BloodMoonDS/main/assets/data/"+dlcname+".json");
		var name:String = "Null";
		DlcDataHttp.onData = function(data:String)
		{
			trace(data);
			saveJson(data,dlcname);
			var filePath = "assets/shared/data/DlcStoreAssets/"+ dlcname +".json";
			var data2 = File.getContent(filePath);
			trace(data2);
			try {
				DlcData = tjson.TJSON.parse(data2);
				trace("tjson.TJSON.parsed JSON: " + DlcData);
				if (DlcData != null && Reflect.hasField(DlcData, "name")) 
				{ 
					name = Reflect.field(DlcData, "name"); 
				
					trace("Name: " + name); 
				
				}
				else 
				{ 
				trace("Error: 'name' field not found in JSON data."); 
				
				}
			}
			catch (e:Dynamic) 
			{
				trace("Error parsing JSON: " + e); 
			}
			

		}
		DlcDataHttp.onError = function(error)
		{
			trace('Error $error');
		}
		DlcDataHttp.request();

		var menuItem:FlxSprite = new FlxSprite(x, y);
		menuItem.frames = Paths.getSparrowAtlas('hud/button');
		menuItem.animation.addByPrefix('idle',"button-idle");
		menuItem.animation.addByPrefix('selected',"button-select");
		var MenuText:FlxText = new FlxText(x , y+12);
		MenuText.setFormat("Segoe UI Symbol", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		MenuText.antialiasing = true;
		
		
		
		MenuText.text = name;
		menuItem.animation.play('idle');
		menuItem.updateHitbox();
		menuItem.antialiasing = ClientPrefs.data.antialiasing;
		menuItem.scrollFactor.set();
		MenuText.scrollFactor.set();
		MenuText.antialiasing = ClientPrefs.data.antialiasing;
		MenuText.centerOrigin();
		MenuText.screenCenter(X);
		menuItems.add(menuItem);
		add(MenuText);
		return menuItem;
	}

	static function saveJson(data:String, name:String) 
	{ 
		var folderPath = "assets/shared/data/DlcStoreAssets";
		var filePath = folderPath +'/' + name + '.json'; 
		if (!FileSystem.exists(folderPath)) 
		{
			 FileSystem.createDirectory(folderPath); 
		}
		File.saveContent(filePath, data); 
		trace("File saved to " + filePath);
	}
	override function create()
	{
		var menuBg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('aquaBGDorfic'));
		menuBg.antialiasing = ClientPrefs.data.antialiasing;
		menuBg.scrollFactor.set(0, 0);
		menuBg.setGraphicSize(Std.int(menuBg.width * 1.175));
		menuBg.updateHitbox();
		menuBg.screenCenter();
		add(menuBg);
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		#if !EXPERIMENTAL_FEATURES
		var ourText = new FlxText(0, 0, FlxG.width,
			"Don't Close That Window!!!. \n
			There you can download all the DLCS.\n
			Unzipping in the 'Mods/' folder",
			32);
		#else
		var ourText = new FlxText(0, 0, FlxG.width,
			"Welcome",
			32);
		#end
		ourText.setFormat("Segoe UI Emoji", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(ourText);
		var curStuff = 1;

		

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
			dlcsaviable = data;
			SeparateTheDlcList(dlcsaviable);
			//jsonString = data;
			//DlcJson = Json.tjson.TJSON.parse(data);
			//trace(DlcJson);
		}
		DlcHttp.onError = function (error)
		{
			trace('error: $error');
		}
		DlcHttp.request(); // you gotta be kidding
		DlcStoreHttp.request();
		#if !EXPERIMENTAL_FEATURES
		#if windows
		Thread.createWithEventLoop(() ->
		{
			var Viewer:WebView = new WebView(#if debug true #end);

			Viewer.setTitle("FNF Vs Bloodiey DLC portal");
			Viewer.setSize(640, 480, 0);
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
		#else
		CoolUtil.browserLoad("https://bloodmoonds.github.io/vs-bloodiey-modstore/");
		#end
		

		//add(spinning = new FlxSprite(0, 0).makeGraphic(100, 100, FlxColor.WHITE));
		//spinning.screenCenter();

		//add(head = new FlxText(50, 50, 0, "HaxeFlixel example", 32));
		//add(body = new FlxText(50, 125, 0, "Waiting for input...", 24));
		#else
		
		for(v in ThisArray)
		{
			trace(v);
			curStuff + 1;
			var item:FlxSprite = createDlcOption(v, 0, (curStuff * 80) + 90);
			item.y += (6 - ThisArray.length) * 20;
			item.screenCenter(X);
		}
		
		#end

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
	#if windows
	private function formatString(s:String):String
	{
		return s.substring(1, s.length - 1);
	}
	#end
}