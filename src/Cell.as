package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

// Created 27.04.2015 at 14:24
public class Cell extends MovieClip{
    private var _row:int;
    private var _col:int;
    public var highlighting:MovieClip;

    public function Cell (row:int, col:int) {
        _row = row;
        _col = col;
        highlighting = new MovieClip();
        highlighting.graphics.beginFill(0xFF0000, 0);
        highlighting.graphics.lineStyle(1, 0xFF0000);
        highlighting.graphics.drawRect(5, 5, 100, 100);
        highlighting.graphics.endFill();
        highlighting.visible = false;
        addChild(highlighting);

        addEventListener(MouseEvent.MOUSE_OVER, OnMOver);
        addEventListener(MouseEvent.MOUSE_OUT, OnMOut);
    }

    private function OnMOver(event:MouseEvent):void {
        highlighting.visible = true;
    }

    private function OnMOut(event:MouseEvent):void {
        highlighting.visible = false;
    }





}
}
