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
                                 complex: {cost:30, income:20, time:15}
    };

    const grid_row:int = 6;
    const grid_col:int = 6;
    private var grid:Array = [[], [], [], [], [], []];
    public var grid_container:MovieClip = new MovieClip();

    public function Field() {
        new Graphics("field", this);
        SetGrid();
        grid_container.x = 200;
        grid_container.y = 100;
        addChild(grid_container);

        Add("complex", 0, 0);
        Add("workshop", 0, 1);
        Add("workshop", 0, 2);
        Add("complex", 1, 0);
        Add("workshop", 1, 1);
        Add("workshop", 1, 2);
        Add("complex", 2, 0);
        Add("workshop", 2, 1);
        Add("workshop", 2, 2);



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

    public function Add(name:String, row:int, col:int):void{
        var cost:int = items[name].cost;
        var revenue:int = items[name].income;
        var time_for_income:Number = items[name].time;

        // проверка что место не зан€то
        if(grid[row][col].numChildren == 1){
            grid[row][col].addChild(new Building(name, cost, revenue, time_for_income));
        }
    }

    public function add_graphics(graphics:MovieClip):void {
        addChildAt(graphics, 0);
    }

}
}
