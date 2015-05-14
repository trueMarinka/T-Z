package {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.SharedObject;

// Created 25.04.2015 at 0:20
public class Field extends Sprite{
    //public const cell_size:int = 50;
    private const grid_row:int = 9;
    private const grid_col:int = 9;
    private var grid:Array = [];
    public var grid_container:MovieClip = new MovieClip();
    public var new_build:String;
    public var build_for_relocate:Building;
    public var test:int;

    public function Field(obj:SharedObject) {
        new Graphics("field", this);
        SetGrid();
        grid_container.x = 540;
        grid_container.y = 101;
        addChild(grid_container);


        if(obj.data.field){
            for (var id:String in obj.data.field) {
                var arr_element:Object = obj.data.field[id];
                Add(false, int(id), arr_element.name, arr_element.y, arr_element.x);
            }
        }

        addEventListener(MouseEvent.MOUSE_DOWN, StartDragging);
        addEventListener(MouseEvent.MOUSE_UP, StopDragging);

    }

    public function RelocateBuilding(id:int, new_row:int, new_col:int):void{
        if(Main.instance.saver.data.field[id]){
            grid[build_for_relocate._row][build_for_relocate._col].removeChild(build_for_relocate);
            grid[new_row][new_col].AddBuilding(build_for_relocate);
            Main.instance.saver.data.field[id].y = new_row;
            Main.instance.saver.data.field[id].x = new_col;
            build_for_relocate = null;
        }
    }

    public function ShowGrid():void{
        for(var i:int = 0; i < grid_row; i++){
            for(var k:int = 0; k < grid_col; k++){
               grid[i][k].draw();
            }
        }
    }

    public function HideGrid():void{
        for(var i:int = 0; i < grid_row; i++){
            for(var k:int = 0; k < grid_col; k++){
                grid[i][k].graphics.clear();
            }
        }
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
            grid[i] = [];
            for(var k:int = 0; k < grid_col; k++){
                cell = new Cell(i, k);
                cell.position = new Point3D(i * cell.cell_size, 0, k * cell.cell_size);
                grid[i].push(cell);
                grid_container.addChild(cell);
            }
        }
    }

    public function Remove(obj:Building):void{
        Main.instance._coins += obj.cost/2;
        Main.instance.gui.money.count.text = Main.instance._coins;
        delete(Main.instance.saver.data.field[obj._id]);      // ������ ������ �� ������� � shared
        obj.RemoveListeners();
        grid[obj._row][obj._col].removeChild(obj);           // ������ ������ �� ������

    }

    public function Add(is_new:Boolean, id:int, name:String, row:int, col:int):void{    // is_new - ����, ��������� �� �� �� shared ��� �������� ����� ������
        var cost:int = Main.ITEMS[name].cost;
        var revenue:int = Main.ITEMS[name].income;
        var time_for_income:Number = Main.ITEMS[name].time;

        // �������� ��� ����� �� ������
        var cell:Cell = grid[row][col];
        if(cell.numChildren == 1){
            var object:Building;
            if(is_new){
                Main.instance.saver.data.field[Main.instance.saver.data.id] = {name:name, x:col, y:row};
                object = new Building(Main.instance.id, name, cost, revenue, time_for_income, row, col); // ���� ����� - ������ � ����� ID
                cell.addChild(object);
                Main.instance.id++;
                Main.instance.saver.data.id = Main.instance.id;
            } else {
                object = new Building(id, name, cost, revenue, time_for_income, row, col);
            }
            cell.AddBuilding(object);
        }
    }

    public function Add_graphics(graphics:MovieClip, name:String):void {
        addChildAt(graphics, 0);
    }
}
}
