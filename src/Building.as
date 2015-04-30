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
    public var id:int;         // ������� � ������� � sharedobject
    public var _row:int;
    public var _col:int;
    private var _type:String;
    private var _cost:int;
    private var _revenue:int;
    private var _revenue_time:int;
    private var info:TextField = new TextField();
    private var ready_info:TextField = new TextField();
    private var timer:Timer;
    private var tmp_timer:Timer;            // ������ ��� ������������ ����������� ������� �� ��������� ������
    private var time_to_get_income:Number;
    private var now:Date = new Date();
    private var point:Point;
    private var ready:Boolean;

    public function Building(_id:int, name:String, cost:int, income:int, time:Number, row:int, col:int) {
        _row = row;
        _col = col;
        ready = false;
        id = _id;
        _type = name;
        _cost = cost;
        _revenue = income;
        _revenue_time = time;
        new Graphics(name, this);
        InfoSettings();
       // timer = new Timer(_revenue_time * 1000, 1);
        timer = new Timer(120000, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);

        addEventListener(MouseEvent.CLICK, OnClick);
        addEventListener(MouseEvent.MOUSE_OVER, OnHover);
        addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
        addEventListener(MouseEvent.MOUSE_DOWN, OnMDown);

        if(Main.instance.saver.data.field[id]["d_time"]){
            if(now.time >= Main.instance.saver.data.field[id].d_time){
                ready = true;
                Signal();
            }
            else{
                var rest_time:Number = Main.instance.saver.data.field[id].d_time - now.time;
                tmp_timer = new Timer(rest_time, 1);
                tmp_timer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
                tmp_timer.start();
            }
        }
        else{
            timer.start();
            //time_to_get_income = now.time + _revenue_time * 1000;   // ���� ����� �� ���� � �������� �� * �� 1000, � ��� - �� 60000 � �.�.
            time_to_get_income = now.time + 120000;   //1 min
            Main.instance.saver.data.field[id].d_time = time_to_get_income;
        }


    }

    private function OnMDown(event:MouseEvent):void {
        startDrag();
        addEventListener(MouseEvent.MOUSE_UP, OnMUp);
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
    }


    private function OnTimerComplete(event:TimerEvent):void {
        ready = true;
        Signal();
    }

    private function OnHover(event:MouseEvent):void {
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

    private function Relocate():void{
        // �������� ���������� ������
    }

    private function OnMUp(event:MouseEvent):void {
       Relocate();
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
        timer.start();
        Main.instance._coins += _revenue;
        Main.instance.gui.money.count.text = Main.instance._coins;
        Main.instance.saver.data.coins = Main.instance._coins;
        //time_to_get_income = now.time + _revenue_time * 1000;
        time_to_get_income = now.time + 120000;
        Main.instance.saver.data.field[id].d_time = time_to_get_income;
        ready_info.visible = false;
    }

    private function Signal():void{         //   �-�  ��������������� ��� ����� �������� ������
        ready_info.visible = true;
    }

    public function get cost():int{
        return _cost;
    }

    public function RemoveListeners():void{
        removeEventListener(MouseEvent.MOUSE_DOWN, OnMDown);
        removeEventListener(MouseEvent.MOUSE_OVER, OnHover);
        removeEventListener(MouseEvent.CLICK, OnClick);
        removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        if(tmp_timer && tmp_timer.hasEventListener(TimerEvent.TIMER_COMPLETE)){
            tmp_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
        }
    }

    public function Add_graphics(graphics:MovieClip, name:String):void {
        graphics.x = 15;
        graphics.y = -15;
        addChild(graphics);
    }

}
}
