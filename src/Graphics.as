package {
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;

// Created 25.04.2015 at 21:41
public class Graphics extends Loader {
    private static var images:Object = {};
    private static var waiting_objects:Object = {};
    private var img:String;
    public function Graphics(name:String, obj:Object) {
        img = name;

        if(images[img]){
            var newContent:MovieClip = new images[img]();
            obj.addChild(newContent);
        }
        else if(waiting_objects[img]){
            waiting_objects[img].push(obj);
        }
        else{
            if(waiting_objects[img] == null){
                waiting_objects[img] = [];
            }
            contentLoaderInfo.addEventListener(Event.INIT, OnImageLoad);
            waiting_objects[img].push(obj);
            load(new URLRequest("../art/" + img + ".swf"));
        }
    }

    private function OnImageLoad(event:Event):void {
        images[img] = contentLoaderInfo.applicationDomain.getDefinition(img) as Class;
        for (var i:int = 0; i < waiting_objects[img].length; i++){
            var newContent:MovieClip = new images[img]();
            waiting_objects[img][i].add_graphics(newContent);
        }
        waiting_objects[img] = null;
    }



}
}
