package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

[Embed(source="../art/graphics.swf", symbol="Interface")]
public class Gui extends MovieClip {
    public var money:MovieClip;
    public var buy:MovieClip;
    public var sell:MovieClip;
    public var move:MovieClip;
    public var can_remove:Boolean;

    public function Gui() {
        super();
        buy.selection.visible = false;
        move.selection.visible = false;
        sell.selection.visible = false;
        money.count.text = Main.instance._coins;
        // не забыть поснимать слушатели
        buy.addEventListener(MouseEvent.CLICK, OnBuyClick);
        sell.addEventListener(MouseEvent.CLICK, OnSellClick);
        move.addEventListener(MouseEvent.CLICK, OnMoveClick);


    }

    private function OnMoveClick(event:MouseEvent):void {
        move.selection.visible = true;
        Main.instance.game_mode = Main.instance.move_mode;
        move.removeEventListener(MouseEvent.CLICK, OnMoveClick);
        move.addEventListener(MouseEvent.CLICK, StopMoving);
    }

    private function StopMoving(event:MouseEvent):void {
        move.selection.visible = false;
        move.removeEventListener(MouseEvent.CLICK, StopMoving);
        move.addEventListener(MouseEvent.CLICK, OnMoveClick);
        Main.instance.game_mode = Main.instance.reg_mode;
    }

    private function OnSellClick(event:MouseEvent):void {
        Main.instance.game_mode = Main.instance.sell_mode;
        sell.selection.visible = true;
        sell.removeEventListener(MouseEvent.CLICK, OnSellClick);
        sell.addEventListener(MouseEvent.CLICK, StopSelling);
    }

    private function StopSelling(event:MouseEvent):void {
        Main.instance.game_mode = Main.instance.reg_mode;
        sell.selection.visible = false;
        sell.removeEventListener(MouseEvent.CLICK, StopSelling);
        sell.addEventListener(MouseEvent.CLICK, OnSellClick);
    }

    private function OnBuyClick(event:MouseEvent):void {
        Main.instance.game_mode = Main.instance.buy_mode;
        buy.selection.visible = true;
        // TO DO показать варианты
    }
}
}
