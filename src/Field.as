package {
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.SharedObject;

// Created 25.04.2015 at 0:20
public class Field extends Sprite{
    private const workshop_pos_x:int = 7;
    private const workshop_pos_y:int = -10;
    private const complex_pos_x:int = 20;
    private const complex_pos_y:int = -20;

    public const cell_size = 50;
    const grid_row:int = 9;
    const grid_col:int = 9;
    private var grid:Array = [];
    public var grid_container:MovieClip = new MovieClip();

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

    public function ShowGrid(){
        for(var i:int = 0; i < grid_row; i++){
            for(var k:int = 0; k < grid_col; k++){
               grid[i][k].draw();
            }
        }
    }

    public function HideGrid(){
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
                cell.position = new Point3D(i * cell_size, 0, k * cell_size);
                grid[i].push(cell);
                grid_container.addChild(cell);
            }
        }
    }

    public function Remove(obj:Building):void{
        Main.instance._coins += obj.cost/2;
        Main.instance.gui.money.count.text = Main.instance._coins;
        delete(Main.instance.saver.data.field[obj.id]);      // удал€ю объект из массива в shared
        obj.RemoveListeners();
        grid[obj._row][obj._col].removeChild(obj);           // удал€ю здание из €чейки

    }

    public function Add(is_new:Boolean, id:int, name:String, row:int, col:int):void{    // is_new - флаг, загружаем ли мы из shared или покупаем новый объект
        var cost:int = Main.instance.items[name].cost;
        var revenue:int = Main.instance.items[name].income;
        var time_for_income:Number = Main.instance.items[name].time;

        // проверка что место не зан€то
        var cell:Cell = grid[row][col];
        if(cell.numChildren == 1){
            var object:Building;
            if(is_new){
                Main.instance.saver.data.field[Main.instance.saver.data.id] = {name:name, x:col, y:row};
                object = new Building(Main.instance.id, name, cost, revenue, time_for_income, row, col); // если новое - создаю с новым ID
                cell.addChild(object);
                Main.instance.id++;
                Main.instance.saver.data.id = Main.instance.id;
            } else {
                object = new Building(id, name, cost, revenue, time_for_income, row, col);
            }
//            switch (name){
//                case "workshop":
//                    object.x = workshop_pos_x;
//                    object.y = workshop_pos_y;
//                    break;
//                case "complex":
//                    object.x = complex_pos_x;
//                    object.y = complex_pos_y;
//                    break;
//            }
            cell.AddBuilding(object);
        }
    }

    public function Add_graphics(graphics:MovieClip, name:String):void {
        addChildAt(graphics, 0);
    }
}
}
