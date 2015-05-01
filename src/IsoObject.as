package {
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

// Created 30.04.2015 at 19:20
public class IsoObject extends Sprite
{
    protected var _position:Point3D;
    protected var _size:Number;

    public function IsoObject(size:Number)
    {
        _size = size;
        _position = new Point3D();
        updateScreenPosition();
    }

//    /**
//     * Преобразование трехмерной позиции объекта в двухмерную
//     * и его размещение на экране.
//     */
    protected function updateScreenPosition():void
    {
        var screenPos:Point = IsoUtils.isoToScreen(_position);
        super.x = screenPos.x;
        super.y = screenPos.y;
    }

    public function set position(value:Point3D):void
    {
        _position = value;
        updateScreenPosition();
    }

    public function get size():Number
    {
        return _size;
    }

}
}
