package states;

import flixel.math.FlxRandom;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import states.VideoPlayerState;

import flixel.FlxObject;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUISlider;
import flixel.addons.ui.FlxUITabMenu;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.ui.FlxButton;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flash.net.FileFilter;
import haxe.Json;
class PasswordState extends MusicBeatState {

    var PasswordText:FlxUIInputText = new FlxUIInputText();
    var PasswordButton:FlxButton = new FlxButton();

    public var Passwords:Array<String> = [
        'l4d2',
        'beasts'
    ];
    function addPasswordUi(){
        PasswordText.setSize(128,32);
        PasswordText.x = 20;
        PasswordText.y = 20;
        PasswordButton.label = new FlxText("Input Password");
        PasswordButton.x = 20 + 128 + 20;
        PasswordButton.y = 20;
        add(PasswordText);
        add(PasswordButton);
    }
    override function create(){
       addPasswordUi();
    }
    override function update(elapsed:Float){
        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
    }
}