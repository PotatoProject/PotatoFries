import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:provider/provider.dart';

class ShapedIcon extends StatelessWidget {
  final String pathData;
  final bool isOutline;
  final double iconSize;
  final Color color;
  final Widget child;

  ShapedIcon({
    @required this.pathData,
    this.isOutline = false,
    this.iconSize = 24,
    this.color,
    this.child,
  }) : assert(pathData != null);

  ShapedIcon.currentShape({
    this.isOutline = false,
    this.iconSize = 24,
    this.color,
    this.child,
  }) : pathData = null;

  @override
  Widget build(BuildContext context) {
    final appInfo = Provider.of<AppInfoProvider>(context);
    Color _color = color ?? Theme.of(context).accentColor;
    String _pathData = pathData ?? appInfo.getIconShape().value;
    _pathData = _pathData?.replaceAll("MM", "M") ?? _pathData;

    return Container(
      height: iconSize,
      width: iconSize,
      child: child,
      decoration: ShapeDecoration(
        shape: !isOutline
            ? PathDataBorder(pathData: _pathData)
            : PathDataBorder(
                pathData: _pathData,
                side: BorderSide(
                  color: _color,
                  width: iconSize / 12,
                ),
              ),
        color: isOutline ? null : _color,
      ),
    );
  }
}

class PathDataBorder extends OutlinedBorder {
  final String pathData;
  final BorderSide side;

  PathDataBorder({
    @required this.pathData,
    this.side = BorderSide.none,
  })  : assert(side != null),
        super(side: side);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return _getPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return _getPath(rect);
  }

  Path _getPath(Rect rect) {
    if (pathData == null) return Path();
    Path path = parseSvgPathData(pathData);
    final matrix4 = Matrix4.identity();
    final pathRect = path.getBounds();
    matrix4.scale(rect.width / pathRect.width, rect.height / pathRect.height);
    path = path.transform(matrix4.storage);
    path = path.shift(Offset(rect.left, rect.top));
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getOuterPath(rect, textDirection: textDirection)
          ..addPath(
              getInnerPath(rect, textDirection: textDirection), Offset.zero);
        canvas.drawPath(path, side.toPaint());
        break;
    }
  }

  @override
  ShapeBorder scale(double t) {
    return PathDataBorder(
      side: side.scale(t),
      pathData: pathData,
    );
  }

  @override
  PathDataBorder copyWith({String pathData, BorderSide side}) {
    return PathDataBorder(
      pathData: pathData ?? this.pathData,
      side: side ?? this.side,
    );
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
