package {

import flash.display.Sprite;
import flash.net.SharedObject;

[SWF(width="800",height="480",frameRate="30")]
public class Main extends Sprite {
    public var shared:SharedObject;
    private static var _instance:Main;
    private var field:Field;
    private var gui:Gui;

    public static function get instance():Main {
        if(_instance == null){
            _instance = new Main();
        }
        return _instance;
    }

    public static var coins:Number;

    public function Main() {
        _instance = this;
        field = new Field();
        gui = new Gui();
        gui.x = stage.stageWidth;
        gui.y = 10;
        addChild(field);
        addChild(gui);

        shared = SharedObject.getLocal("data");
        shared.data.time = new Date().time;
        //trace(shared.data.time);
    }
}
}
