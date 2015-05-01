package {

// Created 30.04.2015 at 19:22
public class DrawnIsoTile extends IsoObject
{
    protected var _height:Number;
    protected var _color:uint;

    public function DrawnIsoTile(size:Number, color:uint, height:Number = 0)
    {
        super(size);
        _color = color;
        _height = height;
        draw();
    }

    /**
     * ������ ������.
     */
    public function draw():void
    {
        graphics.clear();
        graphics.beginFill(_color);
        graphics.lineStyle(0, 0, .5);
        graphics.moveTo(-size, 0);
        graphics.lineTo(0, -size * .5);
        graphics.lineTo(size, 0);
        graphics.lineTo(0, size * .5);
        graphics.lineTo(-size, 0);
    }

}
}
