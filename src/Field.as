package {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.net.SharedObject;
import flash.net.URLRequest;

import flashx.textLayout.operations.MoveChildrenOperation;

// Created 25.04.2015 at 0:20
public class Field extends Sprite{
    private var items:Object = {workshop: {cost:20, income:10, time:5},
                                 complex: {cost:30, income:20, time:15}
    };

    const grid_row:int = 6;
    const grid_col:int = 6;
    private var grid:Array = [[], [], [], [], [], []];
    public var grid_container:MovieClip = new MovieClip();

    public function Field(obj:SharedObject) {
        new Graphics("field", this);
        SetGrid();
        grid_container.x = 200;
        grid_container.y = 100;
        addChild(grid_container);


        if(obj.data.field){
            for (var id:String in obj.data.field) {
                var arr_element:Object = obj.data.field[id];
                Add(false, int(id), arr_element.name, arr_element.y, arr_element.x);
            }
        }

//        Add(true, Main.instance.id, "complex", 0, 0);
//        Add(true, Main.instance.id, "workshop", 0, 1);
//        Add(true, Main.instance.id, "workshop", 0, 2);
//        Add(true, Main.instance.id, "complex", 1, 0);
//        Add(true, Main.instance.id, "workshop", 1, 1);
//        Add(true, Main.instance.id, "workshop", 1, 2);
//        Add(true, Main.instance.id, "complex", 2, 0);
//        Add(true, Main.instance.id, "workshop", 2, 1);
//        Add(true, Main.instance.id, "workshop", 2, 2);

        addEventListener(MouseEvent.MOUSE_DOWN, StartDragging);
        addEventListener(MouseEvent.MOUSE_UP, StopDragging);

    }

    private function StopDragging(event:MouseEvent):void {
        stopDrag();
    }

    private function StartDragging(event:MouseEvent):void {
        if(Main.instance.game_mode == Main.instance.reg_mode){
            startDrag();
        }
    }

    private  function SetGrid():void{
        var cell:Cell;
        for(var i:int = 0; i < grid_row; i++){
            for(var k:int = 0; k < grid_col; k++){
                cell = new Cell(i, k);
                cell.x = k * 100;
                cell.y = i * 100;
                grid[i].push(cell);
                grid_container.addChild(cell);
            }
        }
    }

    public function Remove():void{
        trace("sell");
       for(var i:int = 0; i < grid_row; i++){
           for(var k:int = 0; k < grid_col; k++){
               if(grid[i][k].highlighting.visible){
                   if(grid[i][k].numChildren > 1){
                       Main.instance._coins += grid[i][k].getChildAt(1).cost/2;
                       Main.instance.gui.money.count.text = Main.instance._coins;
                       Main.instance.saver.data.coins = Main.instance._coins;
                       var id_for_delete:int = grid[i][k].getChildAt(1).id;
                       delete(Main.instance.saver.data.field[id_for_delete]);      // удал€ю объект из массива в shared
                       grid[i][k].getChildAt(1).RemoveListeners();
                       grid[i][k].removeChildAt(1);      // удал€ю здание из €чейки
                       grid[i][k].getChildAt(0).visible = false; // убираю выделение
                       return;
                   }
               }
           }
       }
    }

    public function get IsSomethingSelected():Boolean{
        for(var i:int = 0; i < grid_row; i++){
            for(var k:int = 0; k < grid_col; k++){
                if(grid[i][k].highlighting.visible){
                    return true ;
                }
            }
        }
        return false;
    }

    public function Add(is_new:Boolean, id:int, name:String, row:int, col:int):void{    // is_new - флаг, загружаем ли мы из shared или покупаем новый объект
        var cost:int = items[name].cost;
        var revenue:int = items[name].income;
        var time_for_income:Number = items[name].time;

        // проверка что место не зан€то
        if(grid[row][col].numChildren == 1){
            if(is_new){
                Main.instance.saver.data.field[Main.instance.id] = {name:name, x:col, y:row};
                grid[row][col].addChild(new Building(Main.instance.id, name, cost, revenue, time_for_income));        // если новое - создаю с новым ID
                Main.instance.id++;
            }
            else{
                grid[row][col].addChild(new Building(id, name, cost, revenue, time_for_income));
            }

        }
    }

    public function add_graphics(graphics:MovieClip):void {
        addChildAt(graphics, 0);
    }

}
}
