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
    public var _id:int;         // позиция в массиве в sharedobject
    public var _row:int;
    public var _col:int;
    private var _type:String;
    private var _cost:int;
    private var _revenue:int;
    private var _revenue_time:int;
    private var info:TextField = new TextField();
    private var ready_info:TextField = new TextField();
    private var timer:Timer; // таймер для отсчитывания оставшегося времени до получения инкама пссле сохранения
    private var time_to_get_income:Number;
    private var ready:Boolean;
    private var state_of_income:int;

    public function Building(id:int, name:String, cost:int, income:int, time:Number, row:int, col:int) {
        _row = row;
        _col = col;
        ready = false;
        _id = id;
        _type = name;
        _cost = cost;
        _revenue = income;
        _revenue_time = time;                 // в минутах
        new Graphics(name, this);
        InfoSettings();

        addEventListener(MouseEvent.CLICK, OnClick);
        addEventListener(MouseEvent.MOUSE_OVER, OnHover);
        addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);

        if(Main.instance.saver.data.field[id]["d_time"]){
            if(now.time >= Main.instance.saver.data.field[id].d_time){
                ready = true;
                state_of_income = 100;
                Signal();
            }
            else{
                var rest_time:Number = Main.instance.saver.data.field[id].d_time - now.time;
                SetTimer(rest_time);
                time_to_get_income = Main.instance.saver.data.field[id].d_time;
            }
        }
        else{
            SetTimer(_revenue_time * 60000);
            time_to_get_income = now.time + _revenue_time * 60000;
            Main.instance.saver.data.field[id].d_time = time_to_get_income;
        }

    }


    private function InfoSettings():void{
        info.width = ready_info.width = 85;
        info.height = ready_info.height = 20;
        switch (_type){
            case "workshop":
                info.x = -20;
                info.y = -90;
                ready_info.x  = -10;
                ready_info.y = -75;
                break;
            case "complex":
                info.x = -20;
                info.y = -120;
                ready_info.x  = -10;
                ready_info.y = -105;
                break;
        }
        info.textColor = ready_info.textColor = 0xFF0000;
        info.selectable = ready_info.selectable = false;
        info.text = _type  + " " + state_of_income + "%";
        ready_info.text = "$$$";
        info.visible = ready_info.visible = false;
        addChild(ready_info);
        addChild(info);
    }

    private static function get now():Date {
        return new Date();
    }

    private function OnTimerComplete(event:TimerEvent):void {
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        timer.stop();
        timer = null;
        ready = true;
        Signal();
    }

    private function OnHover(event:MouseEvent):void {
        if(state_of_income < 100){
            state_of_income =  100 - ((time_to_get_income - now.time) / (_revenue_time * 60000)) * 100;
        }
        else if(state_of_income > 100){
            state_of_income = 100;
        }
        info.text = _type  + " " + state_of_income + "%";
        ShowInfo();
    }

    private function OnClick(event:MouseEvent):void {
        switch(Main.instance.game_mode){
            case Main.instance.sell_mode:
                Sell();
                break;
            default:
                if(ready){
                   GetIncome();
                }
                break;
        }
    }


    private function Sell():void {
        Main.instance.field.Remove(this);
    }

    private function OnMouseOut(event:MouseEvent):void {
        info.visible = false;
    }

    private function ShowInfo():void{
        info.visible = true;
    }

    private function GetIncome():void{
        SetTimer(_revenue_time * 60000);
        ready = false;
        Main.instance._coins += _revenue;
        Main.instance.gui.money.count.text = Main.instance._coins;
        Main.instance.saver.data.coins = Main.instance._coins;
        time_to_get_income = now.time + _revenue_time * 60000;
        Main.instance.saver.data.field[_id].d_time = time_to_get_income;
        ready_info.visible = false;
        state_of_income =  100 - ((time_to_get_income - now.time) / (_revenue_time * 60000)) * 100;
        info.text = _type  + " " + state_of_income + "%";
    }

    private function SetTimer(time:Number):void{
        if (timer) {
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        }
        timer = new Timer(time, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        timer.start();
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
        if (timer) {
            timer.stop();
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        }
    }

    public function Add_graphics(graphics:MovieClip, name:String):void {
        var item:Object = Main.ITEMS[name];
        graphics.x = item.pos_x;
        graphics.y = item.pos_y;
        addChild(graphics);
    }

}
}
