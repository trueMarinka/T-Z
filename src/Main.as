package {

import flash.display.Sprite;
import flash.events.Event;
import flash.net.SharedObject;

[SWF(width="800",height="480",frameRate="30")]
public class Main extends Sprite {
    public var saver:SharedObject;
    public var id:int;
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

    public var _coins:int;

    public function Main() {
        saver = SharedObject.getLocal("Data");
        //saver.clear();
        if(!saver.data.coins){                      // если первый запуск
            _coins = 1000;
            saver.data.coins = _coins;
            saver.data.field = {};
            id = 1;
        }
        else{
            _coins = saver.data.coins;
        }
        _instance = this;
        game_mode = reg_mode;
        field = new Field(saver);
        gui = new Gui();
        gui.x = stage.stageWidth;
        gui.y = 10;
        addChild(field);
        addChild(gui);
        trace(saver.data.field.length);

//        shared = SharedObject.getLocal("data");
//        shared.data.time = new Date().time;
        //trace(shared.data.time);




    }



}
}
