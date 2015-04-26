package {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.text.TextField;

// Created 24.04.2015 at 23:22
public class Building extends Sprite{
    private var _type:String;
    private var _cost:int;
    private var _revenue:int;
    private var _revenue_time:Number;
    private var info:TextField;

    public function Building(name:String, x:Number, y:Number, cost:int, income:int, time:Number) {
        this.x = x;
        this.y = y;
        _type = name;
        _cost = cost;
        _revenue = income;
        _revenue_time = time;
        var img:Graphics = new Graphics(name);
        addChild(img);
        addEventListener(MouseEvent.MOUSE_OVER, OnHover);
//        graphics.beginFill(0x000000);
//        graphics.drawRect(0, 0, 50, 50);
//        graphics.endFill();

    }

    private function OnHover(event:MouseEvent):void {
          ShowInfo();
    }

    private function ShowInfo():void{
        info = new TextField();
        info.x = x;
        info.y = y - 20;
        info.text = _type;
        addChild(info);
        trace("1");
    }

    public function get type():String{
        return _type;
    }

    public function get cost():Number{
        return _cost;
    }

    public function get revenue():Number{
        return _revenue;
    }

    public function get revenue_time():Number{
        return _revenue_time;
    }

    public function get pos_x():Number{
        return x;
    }

    public function get pos_y():Number{
        return y;
    }

}
}
