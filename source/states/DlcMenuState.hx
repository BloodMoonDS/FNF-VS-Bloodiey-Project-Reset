package states;

import haxe.Http;
import backend.WeekData;
import backend.Mods;

import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLRequestMethod;
import openfl.events.Event;

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

class DlcMenuState extends MusicBeatState
{

	var DlcJson:Json;
	var DlcDir:String = "http://bloodieysart.rf.gd/wp-content/funkindlcs/dlcList.json";
	
	public var EngineVer:String;

	override public function create():Void
	{
		var JsonDat;

		EngineVer = MainMenuState.vsBloodieyVer;
		trace(EngineVer);
		var DlcHttp = new Http(DlcDir);
		
		DlcHttp.onData = function (data:String)
		{
			JsonDat = Json.parse(data);
			trace(data);
		}
		DlcHttp.onError = function (error)
		{
			trace('error: $error');
		}
		loadJSONFromURL(DlcDir);
		trace(DlcDir);
		// trace(DlcJson);
		//trace(JsonDat);

	}
	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
	}
	public function loadJSONFromURL(url: String): Void {
        // Crear la solicitud HTTP
        var request: URLRequest = new URLRequest(url);
        request.method = URLRequestMethod.GET;

        // Crear el cargador de URL
        var loader: URLLoader = new URLLoader();

        // Asignar la función que se llamará cuando la carga esté completa
        loader.addEventListener(Event.COMPLETE, onJSONLoaded);

        // Enviar la solicitud
        loader.load(request);
    }
	function onJSONLoaded(event: Event): Void {
        // Obtener el loader desde el evento
        var loader: URLLoader = cast(event.target, URLLoader);
        
        // Convertir los datos cargados en JSON
        var jsonData: Dynamic = haxe.Json.parse(loader.data);
        
        // Procesar los datos JSON (ejemplo: imprimir en la consola)
        trace(jsonData);
        trace(DlcDir);
		DlcJson = jsonData;

        // Aquí puedes hacer lo que necesites con los datos JSON
    }
}