package {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

// Created 30.04.2015 at 15:36
[Embed(source="../art/graphics.swf", symbol="Buy_panel")]
public class Buy_Panel extends Sprite{
    public var workshop_wind:MovieClip;
    public var complex_wind:MovieClip;
    private var maska:Sprite;

    public function Buy_Panel() {
        maska = new Sprite();
        maska.graphics.beginFill(0x46B1E7, 0.5);
        maska.graphics.drawRect(0, 0, Main.instance.stage.stageWidth, Main.instance.stage.stageHeight);
        maska.graphics.endFill();
        Main.instance.addChildAt(maska, 2);
        maska.addEventListener(MouseEvent.CLICK, ExitBuying);

        x = Main.instance.stage.stageWidth/2 - width/2;
        y = Main.instance.stage.stageHeight/2 - height/2;
        workshop_wind.cost.text = Main.ITEMS.workshop.cost;
        complex_wind.cost.text = Main.ITEMS.complex.cost;
        new Graphics("workshop", this);
        new Graphics("complex", this);

        workshop_wind.ok_btn.addEventListener(MouseEvent.CLICK, OnClick);
        complex_wind.ok_btn.addEventListener(MouseEvent.CLICK, OnClick);
    }

    private function ExitBuying(event:MouseEvent):void {
        Main.instance.gui.StopBuying(event);
        DestroyMe();
    }

    private function OnClick(event:MouseEvent):void {
        switch (event.target.parent.name){
            case "workshop_wind":
                    Main.instance.field.new_build = "workshop";
                break;
            case "complex_wind":
                Main.instance.field.new_build= "complex";
                break;
        }

        DestroyMe();
    }


    private function DestroyMe():void{
        Main.instance.removeChildAt(2);                 // ������� �����
        workshop_wind.ok_btn.removeEventListener(MouseEvent.CLICK, OnClick);
        complex_wind.ok_btn.removeEventListener(MouseEvent.CLICK, OnClick);
        Main.instance.removeChild(this);
    }

    public function Add_graphics(graphics:MovieClip, name:String):void {
        graphics.x = graphics.width/2;
        graphics.y = graphics.height/2;
        switch (name){
            case "workshop":
                workshop_wind.addChild(graphics);
                break;
            case "complex":
                complex_wind.addChild(graphics);
                break;
        }
    }


}
}
