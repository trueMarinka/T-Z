package {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;

// Created 25.04.2015 at 21:41
public class Graphics extends Loader {
    private static var images:Object = {};
    private var img:String;
    public function Graphics(name:String) {
        img = name;

        if(!images[img]){          // если нет в массиве - то загружаю и добавляю в массив
            contentLoaderInfo.addEventListener(Event.COMPLETE, OnImageLoad);
            load(new URLRequest("../art/" + img + ".swf"));
        } else {
           addChild(images[img]);
        }

    }



    private function OnImageLoad(event:Event):void {
         images[img] = contentLoaderInfo.applicationDomain.getDefinition(img) as Class;
        var newContent:MovieClip = new images[img]();
    }



}
}
