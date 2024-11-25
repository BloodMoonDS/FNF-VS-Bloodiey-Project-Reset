package states;

import flixel.math.FlxRandom;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import states.DlcMenuState;
import flash.system.System;

enum ExtraMenuColumn {
	CENTER;
}

class ExtrasState extends MusicBeatState
{
	public static var MODTUrl:String = "http://bloodieysart.rf.gd/media/motd.txt";
	var MODTHttp = new haxe.Http(MODTUrl);
	public var MOTDText:String;

	public static var psychEngineVersion:String = '1.0'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curColumn:ExtraMenuColumn = CENTER;

	var leftItem:FlxSprite;
	var rightItem:FlxSprite;
	var allowMouse:Bool = true; //Turn this off to block mouse movement in menus

	var menuItems:FlxTypedGroup<FlxSprite>;
	public var optionShit:Array<String> = [
		'dlcs',
		'back'
	];

	var leftOption:String = #if ACHIEVEMENTS_ALLOWED 'achievements' #else null #end;
	var rightOption:String = 'options';

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var mustoplay:Int=1;

	

	override function create()
	{
		FlxG.sound.playMusic(Paths.music('opal'), 0);

	}
	override function update(elapsed):Void
	{
		
		super.update(elapsed);
	}
	function createMenuItem()
	{


	}
}
