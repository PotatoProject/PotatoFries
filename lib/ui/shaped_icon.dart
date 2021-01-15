import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
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
    final appInfo = context.watch<AppInfoProvider>();
    final provider = context.watch<PageProvider>();
    Color _color = color ?? Theme.of(context).accentColor;
    String _pathData = pathData ?? provider.getIconShape(appInfo.shapes).value;

    return SizedBox.fromSize(
      size: Size.square(iconSize),
      child: Material(
        color: isOutline ? null : _color,
        child: child,
        clipBehavior: Clip.antiAlias,
        shape: !isOutline
            ? PathDataBorder(pathData: _pathData)
            : PathDataBorder(
                pathData: _pathData,
                side: BorderSide(
                  color: _color,
                  width: iconSize / 6,
                ),
              ),
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
    Path path = parseSvgPathData(pathData.replaceAll("MM", "M"));
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
