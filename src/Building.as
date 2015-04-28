package {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;

// Created 24.04.2015 at 23:22
public class Building extends Sprite{
    private var _type:String;
    private var _cost:int;
    private var _revenue:int;
    private var _revenue_time:int;
    private var info:TextField = new TextField();
    private var ready_info:TextField = new TextField();
    private var timer:Timer;
    private var ready:Boolean;
    private var point:Point;

    public function Building(name:String, cost:int, income:int, time:Number) {
        ready = false;
        _type = name;
        _cost = cost;
        _revenue = income;
        _revenue_time = time;
        new Graphics(name, this);

        addEventListener(MouseEvent.CLICK, OnClick);
        addEventListener(MouseEvent.MOUSE_OVER, OnHover);
        addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);

        InfoSettings();
        timer = new Timer(_revenue_time * 1000, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        timer.start();



    }
    private function InfoSettings():void{
        info.width = ready_info.width = 55;
        info.height = ready_info.height = 20;
        info.defaultTextFormat.align = "center";
        ready_info.defaultTextFormat.align = "center";
        info.x = x + 110/3;
        ready_info.x  = 110/2;
        info.y = y - 30;
        ready_info.y = y - 15;
        info.textColor = ready_info.textColor = 0xFF0000;
        info.selectable = ready_info.selectable = false;
        info.text = _type;
        ready_info.text = "$$$";
        info.visible = ready_info.visible = false;
        addChild(ready_info);
        addChild(info);
        trace(info.width);
    }

    private function ToGetIncome(event:MouseEvent):void {
        if(ready){
            timer.start();
            ready = false;
            Main.instance._coins += _revenue;
            Main.instance.gui.money.count.text = Main.instance._coins;
            ready_info.visible = false;
        }
        removeEventListener(MouseEvent.CLICK,ToGetIncome);
    }

    private function OnTimerComplete(event:TimerEvent):void {
        ready = true;
        Signal();
        addEventListener(MouseEvent.CLICK, ToGetIncome);
    }

    private function OnHover(event:MouseEvent):void {
        ShowInfo();

    }

    private function OnClick(event:MouseEvent):void {
        switch(Main.instance.game_mode){
            case Main.instance.sell_mode:
                Sell();
                break;
            case Main.instance.move_mode:

                break;
            case Main.instance.buy_mode:

                break;
        }

    }

    private function Sell():void {
        Main.instance.field.Remove();
    }

    private function OnMouseOut(event:MouseEvent):void {
        info.visible = false;
    }

    private function ShowInfo():void{
        info.visible = true;
    }

    private function Signal():void{         //   ф-я  сигнализирующая что можно получить деньги
        ready_info.visible = true;
    }

    public function get cost():int{
        return _cost;
    }

    public function RemoveListeners():void{
        removeEventListener(MouseEvent.MOUSE_OVER, OnHover);
        removeEventListener(MouseEvent.CLICK, OnClick);
        removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
    }


//    public function get type():String{
//        return _type;
//    }
//
//
//    public function get revenue():Number{
//        return _revenue;
//    }
//
//    public function get revenue_time():Number{
//        return _revenue_time;
//    }

    public function add_graphics(graphics:MovieClip):void {
        addChild(graphics);
    }

}
}
