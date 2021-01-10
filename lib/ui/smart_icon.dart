import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/svg.dart';

class SmartIcon extends StatelessWidget {
  final SmartIconData iconData;
  final double size;
  final Color color;

  SmartIcon(
    this.iconData, {
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var _color = Theme.of(context).iconTheme.color;

    if (iconData == null) {
      return SizedBox.fromSize(
        size: Size.square(size ?? 24),
      );
    }

    switch (iconData.type) {
      case SmartIconType.SVG:
        return SvgPicture.asset(
          iconData.data,
          height: size ?? 24,
          width: size ?? 24,
          color: _color,
        );
      case SmartIconType.ANDROID_VECTOR:
        return SizedBox.fromSize(
          size: Size.square(size ?? 24),
          child: AvdPicture.asset(
            iconData.data,
            color: _color,
          ),
        );
      case SmartIconType.ICON_DATA:
      default:
        return Icon(
          iconData.data,
          size: size,
          color: _color,
        );
    }
  }
}

class SmartIconData {
  dynamic data;
  SmartIconType type;

  SmartIconData.iconData(
    IconData data,
  )   : this.data = data,
        this.type = SmartIconType.ICON_DATA;

  SmartIconData.svg(
    String data,
  )   : assert(data.endsWith("svg")),
        this.data = data,
        this.type = SmartIconType.SVG;

  SmartIconData.androidVector(
    String data,
  )   : assert(data.endsWith("xml")),
        this.data = data,
        this.type = SmartIconType.ANDROID_VECTOR;
}

enum SmartIconType {
  ICON_DATA,
  SVG,
  ANDROID_VECTOR,
}
