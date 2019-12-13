import 'package:flutter/material.dart';

class FavColorTile extends StatelessWidget {
  final HSLColor base;
  final double lightLightness;
  final double darkLightness;
  final double size;
  final void Function(HSLColor, double, double) onTap;
  final Function() onDelete;

  FavColorTile({
    @required this.base,
    @required this.lightLightness,
    @required this.darkLightness,
    this.size = 48,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox.fromSize(
        size: Size.square(size),
        child: InkWell(
          onTap: () => onTap(base, lightLightness, darkLightness),
          onLongPress: onDelete,
          borderRadius: BorderRadius.circular(size / 2),
          child: Row(
            children: <Widget>[
              Container(
                height: size,
                width: size / 2,
                decoration: BoxDecoration(
                  color: base.withLightness(lightLightness).toColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size / 2),
                    bottomLeft: Radius.circular(size / 2)
                  ),
                ),
              ),
              Container(
                height: size,
                width: size / 2,
                decoration: BoxDecoration(
                  color: base.withLightness(darkLightness).toColor(),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size / 2),
                    bottomRight: Radius.circular(size / 2)
                  ),
                ),
              ),
            ],
          )
        )
      )
    );
  }
}