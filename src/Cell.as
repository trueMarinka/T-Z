package {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

// Created 27.04.2015 at 14:24
public class Cell extends DrawnIsoTile{
    private var _row:int;
    private var _col:int;
    private var _highlighting:Sprite;
    public const cell_size:int = 50;

    public function Cell (row:int, col:int) {
        super(cell_size,0xcccccc);
        graphics.clear();
        _row = row;
        _col = col;
        _highlighting = new Sprite();
        addChild(_highlighting);

        addEventListener(MouseEvent.MOUSE_OVER, OnMOver);
        addEventListener(MouseEvent.MOUSE_OUT, OnMOut);
        addEventListener(MouseEvent.CLICK, OnClick);
    }

    public function AddBuilding(obj:Building):void {
        addChild(obj);
        obj._row = _row;
        obj._col = _col;
    }

    override public function draw():void {
        graphics.clear();
        graphics.beginFill(_color, 0.2);
        graphics.lineStyle(0, 0, .5);
        graphics.moveTo(-size, 0);
        graphics.lineTo(0, -size * .5);
        graphics.lineTo(size, 0);
        graphics.lineTo(0, size * .5);
        graphics.lineTo(-size, 0);
    }

    private function OnClick(event:MouseEvent):void {
        switch (Main.instance.game_mode){
            case Main.instance.buy_mode:
                Buy(Main.instance.field.new_build);
                Main.instance.gui.StopBuying(event);
                break;
            case Main.instance.move_mode:
                if(numChildren > 1){                // ���� ������ �� �� ������ ������
                    var obj:Building = getChildAt(1) as Building;
                    Main.instance.field.build_for_relocate = obj;
                }
                else{
                    if(Main.instance.field.build_for_relocate){
                         Main.instance.field.RelocateBuilding(Main.instance.field.build_for_relocate._id, _row, _col);
                    }
                }
                break;
        }
    }

    private function Buy(name:String):void{
        if(numChildren == 1){
            var cost:int = Main.ITEMS[name].cost;

            if(Main.instance._coins >= cost){
                Main.instance.field.Add(true, Main.instance.id, name, _row, _col);
                Main.instance._coins -= cost;
                Main.instance.gui.money.count.text = Main.instance._coins;
                Main.instance.saver.data.coins = Main.instance._coins
            }
        }
    }


    private function OnMOver(event:MouseEvent):void {
        _highlighting.graphics.lineStyle(3, 0x0033FF);
        _highlighting.graphics.moveTo(-size - 0.1, 0);
        _highlighting.graphics.lineTo(0, -size / 2 - 0.1);
        _highlighting.graphics.lineTo(size, 0);
        _highlighting.graphics.lineTo(0, size / 2 + 0.1);
        _highlighting.graphics.lineTo(-size - 0.1, 0);
    }

    private function OnMOut(event:MouseEvent):void {
        _highlighting.graphics.clear();
    }


    public function get highlighting():Sprite {
        return _highlighting;
    }
}
}
