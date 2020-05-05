import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/svg.dart';

class SmartIcon extends StatelessWidget {
  final dynamic iconData;
  final double size;
  final Color color;

  SmartIcon(
    this.iconData, {
      this.size,
      this.color,
    }
  );

  @override
  Widget build(BuildContext context) {
    var _color =
        color ?? Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
    if(iconData is IconData) {
      return Icon(
        iconData,
        size: size,
        color: _color,
      );
    } else if(iconData is String) {
      if((iconData as String).endsWith("svg")) {
        return SvgPicture.asset(
          iconData,
          height: size ?? 24,
          width: size ?? 24,
          color: _color,
        );
      } else if((iconData as String).endsWith("xml")) {
        return SizedBox.fromSize(
          size: Size.square(size ?? 24),
          child: AvdPicture.asset(
            iconData,
            color: _color,
          ),
        );
      } else throw TypeError();
    } else if(iconData == null) {
      return SizedBox.fromSize(
        size: Size.square(size ?? 24),
      );
    } else {
      throw TypeError();
    }
  }
}