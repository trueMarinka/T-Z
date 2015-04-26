package {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.net.URLRequest;

import flashx.textLayout.operations.MoveChildrenOperation;

// Created 25.04.2015 at 0:20
public class Field extends Sprite{
    private var items:Object = {workshop: {cost:20, income:10, time:5},
                                 complex: {cost:30, income:20, time:15}};

    private var buildings_arr:Array = [];

    public function Field() {
        var container:Graphics = new Graphics("field");
        container.x = -100;
        container.y = -50;
        addChild(container);
        Add("complex", 123, 203);
        Add("workshop", 223, 153);
        Add("workshop", 323, 103);



    }

    public function Remove(obj:DisplayObject):void{          // не правильно, надо как-то через массив строений удалять
       removeChild(obj);
    }

    private function Add(name:String, pos_x:int, pos_y:int):void{
        var cost:int = items[name].cost;
        var revenue:int = items[name].income;
        var time_for_income:Number = items[name].time;

        buildings_arr.push(new Building(name, pos_x, pos_y, cost, revenue, time_for_income));
        addChild(buildings_arr[buildings_arr.length-1]);
    }
}
}
