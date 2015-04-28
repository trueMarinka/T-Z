package {

import flash.display.Sprite;
import flash.events.Event;
import flash.net.SharedObject;

[SWF(width="800",height="480",frameRate="30")]
public class Main extends Sprite {
    public var shared:SharedObject;
    private static var _instance:Main;
    public var field:Field;
    public var gui:Gui;
    public var move_mode:String = "move";
    public var sell_mode:String = "sell";
    public var buy_mode:String = "buy";
    public var reg_mode:String = "regular";
    public var game_mode:String;

    public static function get instance():Main {
        if(_instance == null){
            _instance = new Main();
        }
        return _instance;
    }

    public var _coins:int = 0;

    public function Main() {
        _instance = this;
        game_mode = reg_mode;
        field = new Field();
        gui = new Gui();
        gui.x = stage.stageWidth;
        gui.y = 10;
        addChild(field);
        addChild(gui);

//        shared = SharedObject.getLocal("data");
//        shared.data.time = new Date().time;
        //trace(shared.data.time);




    }



}
}
