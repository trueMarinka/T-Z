package {
import flash.geom.Point;

// Created 30.04.2015 at 19:18
public class IsoUtils
{
    // ����� ������ �������� 1.2247...
    public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

    /**
     * �� ����������� ������������ � ����������.
     * @arg pos ����� ����������� ������������.
     */
    public static function isoToScreen(pos:Point3D):Point
    {
        var screenX:Number = pos.x - pos.z;
        var screenY:Number = pos.y * Y_CORRECT + (pos.x + pos.z) * .5;
        return new Point(screenX, screenY);
    }

    /**
     * �� ����������� ������������ � ����������, ������ � ����� ����.
     * @arg point ����� � ���������� ������������.
     */
    public static function screenToIso(point:Point):Point3D
    {
        var xpos:Number = point.y + point.x * .5;
        var ypos:Number = 0;
        var zpos:Number = point.y - point.x * .5;
        return new Point3D(xpos, ypos, zpos);
    }

}
}
