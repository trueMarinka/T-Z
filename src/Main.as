package {

import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.net.SharedObject;

[SWF(width="800",height="480",frameRate="30")]
public class Main extends Sprite {
    private static var _stage:Stage;
    public static function get stage():Stage {
        return _stage;
    }

    public static const ITEMS:Object = {
        workshop: {cost:20, income:10, time:5, pos_x: 2, pos_y: -12},
        complex: {cost:30, income:20, time:15, pos_x: 2, pos_y: -32}
    };
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
        if(!saver.data.id){                      // если первый запуск
            _coins = 1000;
            saver.data.coins = _coins;
            saver.data.field = {};
            id = 1;
            saver.data.id = id;
        }
        else{
            id = saver.data.id;
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
    }



}
}
