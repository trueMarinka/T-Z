package {
import flash.display.MovieClip;
import flash.events.MouseEvent;

[Embed(source="../art/graphics.swf", symbol="Interface")]
public class Gui extends MovieClip {
    public var money:MovieClip;
    public var buy:MovieClip;
    public var sell:MovieClip;
    public var move:MovieClip;

    public function Gui() {
        super();
        money.count.text = "364k";
        buy.addEventListener(MouseEvent.CLICK, OnBuyClick);
        sell.addEventListener(MouseEvent.CLICK, OnSellClick);
        move.addEventListener(MouseEvent.CLICK, OnMoveClick);
    }

    private function OnMoveClick(event:MouseEvent):void {
        trace("move");
    }

    private function OnSellClick(event:MouseEvent):void {
        trace("sell");
    }

    private function OnBuyClick(event:MouseEvent):void {
        trace("buy");
    }
}
}
