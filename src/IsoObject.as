package {
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

// Created 30.04.2015 at 19:20
public class IsoObject extends Sprite
{
    protected var _position:Point3D;
    protected var _size:Number;
//    protected var _walkable:Boolean = false;
//    protected var _vx:Number = 0;
//    protected var _vy:Number = 0;
//    protected var _vz:Number = 0;

    //public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

    public function IsoObject(size:Number)
    {
        _size = size;
        _position = new Point3D();
        updateScreenPosition();
    }

//    /**
//     * �������������� ���������� ������� ������� � ����������
//     * � ��� ���������� �� ������.
//     */
    protected function updateScreenPosition():void
    {
        var screenPos:Point = IsoUtils.isoToScreen(_position);
        super.x = screenPos.x;
        super.y = screenPos.y;
    }
//
//    /**
//     * ��������� ������������� �������.
//     */
//    override public function toString():String
//    {
//        return "[IsoObject (x:" + _position.x + ", y:" + _position.y + ", z:" + _position.z + ")]";
//    }

//    /**
//     * ������/������ ���������� � � ���������� ������������.
//     */
//    override public function set x(value:Number):void
//    {
//        _position.x = value;
//        updateScreenPosition();
//    }
//    override public function get x():Number
//    {
//        return _position.x;
//    }
//
//    /**
//     * ������/������ ���������� � � ���������� ������������.
//     */
//    override public function set y(value:Number):void
//    {
//        _position.y = value;
//        updateScreenPosition();
//    }
//    override public function get y():Number
//    {
//        return _position.y;
//    }
//
//    /**
//     * ������/������ ���������� z � ���������� ������������.
//     */
//    override public function set z(value:Number):void
//    {
//        _position.z = value;
//        updateScreenPosition();
//    }
//    override public function get z():Number
//    {
//        return _position.z;
//    }
//
    /**
     * ������/������ ������� � ���������� ������������ ��� ���������� Point3D.
     */
    public function set position(value:Point3D):void
    {
        _position = value;
        updateScreenPosition();
    }
//    public function get position():Point3D
//    {
//        return _position;
//    }

//    /**
//     * ���������� ������� �������.
//     */
//    public function get depth():Number
//    {
//        return (_position.x + _position.z) * .866 - _position.y * .707;
//    }
//
//    /**
//     * ���������, ����� �� �����, ������� ���� ��������, ���� ������ ������ ��������.
//     */
//    public function set walkable(value:Boolean):void
//    {
//        _walkable = value;
//    }
//    public function get walkable():Boolean
//    {
//        return _walkable;
//    }
//

    /**
     * ���������� ������ �������
     */
    public function get size():Number
    {
        return _size;
    }
//
//    /**
//     * ���������� ���������� ������� �� x-z ���������, ������� �������� ���� ������.
//     */
//    public function get rect():Rectangle
//    {
//        return new Rectangle(x - size / 2, z - size / 2, size, size);
//    }
//
//    /**
//     * ������/������ �������� �� ��� �.
//     */
//    public function set vx(value:Number):void
//    {
//        _vx = value;
//    }
//    public function get vx():Number
//    {
//        return _vx;
//    }
//
//    /**
//     * ������/������ �������� �� ��� �.
//     */
//    public function set vy(value:Number):void
//    {
//        _vy = value;
//    }
//    public function get vy():Number
//    {
//        return _vy;
//    }
//
//    /**
//     * ������/������ �������� �� ��� z.
//     */
//    public function set vz(value:Number):void
//    {
//        _vz = value;
//    }
//    public function get vz():Number
//    {
//        return _vz;
//    }
}
}
