package {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

[Embed(source="../art/graphics.swf", symbol="Interface")]
public class Gui extends MovieClip {
    public var money:MovieClip;
    public var buy:MovieClip;
    public var sell:MovieClip;
    public var move:MovieClip;
    public var can_remove:Boolean;
    public var buy_panel:Buy_Panel;
    public var maska:Sprite;
    private var is_pressed:Boolean = false;

    public function Gui() {
        super();
        buy.selection.visible = false;
        move.selection.visible = false;
        sell.selection.visible = false;
        money.count.text = Main.instance._coins;
        buy.addEventListener(MouseEvent.CLICK, OnBuyClick);
        sell.addEventListener(MouseEvent.CLICK, OnSellClick);
        move.addEventListener(MouseEvent.CLICK, OnMoveClick);
    }

    private function OnMoveClick(event:MouseEvent):void {
        CancelSelections(sell);
        CancelSelections(buy);
        Main.instance.field.ShowGrid();
        move.selection.visible = true;
        Main.instance.game_mode = Main.instance.move_mode;
        move.removeEventListener(MouseEvent.CLICK, OnMoveClick);
        move.addEventListener(MouseEvent.CLICK, StopMoving);
    }

    private function StopMoving(event:MouseEvent):void {
        move.selection.visible = false;
        move.removeEventListener(MouseEvent.CLICK, StopMoving);
        move.addEventListener(MouseEvent.CLICK, OnMoveClick);
        Main.instance.field.HideGrid();
        Main.instance.game_mode = Main.instance.reg_mode;
    }

    private function OnSellClick(event:MouseEvent):void {
        CancelSelections(move);
        CancelSelections(buy);
        Main.instance.field.ShowGrid();
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
        Main.instance.field.HideGrid();
    }

    private function OnBuyClick(event:MouseEvent):void {
        CancelSelections(sell);
        CancelSelections(move);
        Main.instance.field.ShowGrid();
        Main.instance.game_mode = Main.instance.buy_mode;
        buy.selection.visible = true;
        buy_panel = new Buy_Panel();
        Main.instance.addChildAt(buy_panel, 3);
        buy.removeEventListener(MouseEvent.CLICK, OnBuyClick);
        buy.addEventListener(MouseEvent.CLICK, StopBuying);
    }

    public function StopBuying(event:MouseEvent):void{
        Main.instance.game_mode = Main.instance.reg_mode;
        buy.selection.visible = false;
        Main.instance.field.HideGrid();
        buy.addEventListener(MouseEvent.CLICK, OnBuyClick);
    }

    public function CancelSelections(btn:MovieClip){
        if(btn.selection.visible){
            btn.selection.visible = false;
        }
    }
}
}
