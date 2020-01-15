import 'package:flutter/material.dart';

class ShapedIcon extends StatelessWidget {
  final int type;
  final bool isOutline;
  final double iconSize;
  final Color color;
  final Widget child;

  ShapedIcon({
    @required this.type,
    this.isOutline = false,
    this.iconSize = 24,
    this.color,
    this.child,
  }) : assert(type != null);

  @override
  Widget build(BuildContext context) {
    Color _color = color ?? Theme.of(context).accentColor;
    switch (type) {
      case 0:
        // circle
        return Container(
          height: iconSize,
          width: iconSize,
          child: child,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(iconSize),
            border: !isOutline
                ? null
                : Border.fromBorderSide(
                    BorderSide(
                      color: _color,
                      width: iconSize / 12,
                    ),
                  ),
            color: isOutline ? null : _color,
          ),
        );
      case 1:
        // teardrop
        return Container(
          height: iconSize,
          width: iconSize,
          child: child,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(iconSize),
              topRight: Radius.circular(iconSize),
              bottomLeft: Radius.circular(iconSize),
              bottomRight: Radius.circular(iconSize / 6),
            ),
            border: !isOutline
                ? null
                : Border.fromBorderSide(
                    BorderSide(
                      color: _color,
                      width: iconSize / 12,
                    ),
                  ),
            color: isOutline ? null : _color,
          ),
        );
      case 2:
        // rounded square
        return Container(
          height: iconSize,
          width: iconSize,
          child: child,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(iconSize / 6),
              topRight: Radius.circular(iconSize / 6),
              bottomLeft: Radius.circular(iconSize / 6),
              bottomRight: Radius.circular(iconSize / 6),
            ),
            border: !isOutline
                ? null
                : Border.fromBorderSide(
                    BorderSide(
                      color: _color,
                      width: iconSize / 12,
                    ),
                  ),
            color: isOutline ? null : _color,
          ),
        );
      case 3:
        // squircle
        return Container(
          height: iconSize,
          width: iconSize,
          child: Material(
            color: isOutline ? Colors.transparent : _color,
            child: child,
            shape: SquircleBorder(
              side: isOutline
                  ? BorderSide(
                      color: _color,
                      width: iconSize / 12,
                    )
                  : BorderSide.none,
            ),
          ),
        );
      default:
        return Container(width: iconSize, height: iconSize);
    }
  }
}

// stolen from https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a
class SquircleBorder extends ShapeBorder {
  final BorderSide side;
  final double superRadius;

  const SquircleBorder({
    this.side: BorderSide.none,
    this.superRadius: 5.0,
  })  : assert(side != null),
        assert(superRadius != null);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return new SquircleBorder(
      side: side.scale(t),
      superRadius: superRadius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return _squirclePath(rect.deflate(side.width), superRadius);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return _squirclePath(rect, superRadius);
  }

  static Path _squirclePath(Rect rect, double superRadius) {
    final c = rect.center;
    final dx = c.dx * (1.0 / superRadius);
    final dy = c.dy * (1.0 / superRadius);
    return new Path()
      ..moveTo(c.dx, 0.0)
      ..relativeCubicTo(c.dx - dx, 0.0, c.dx, dy, c.dx, c.dy)
      ..relativeCubicTo(0.0, c.dy - dy, -dx, c.dy, -c.dx, c.dy)
      ..relativeCubicTo(-(c.dx - dx), 0.0, -c.dx, -dy, -c.dx, -c.dy)
      ..relativeCubicTo(0.0, -(c.dy - dy), dx, -c.dy, c.dx, -c.dy)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        var path = getOuterPath(rect.deflate(side.width / 2.0),
            textDirection: textDirection);
        canvas.drawPath(path, side.toPaint());
    }
  }
}
