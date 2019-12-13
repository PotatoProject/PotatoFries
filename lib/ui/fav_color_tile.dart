import 'package:flutter/material.dart';

class FavColorTile extends StatelessWidget {
  final HSLColor light;
  final HSLColor dark;
  final double size;
  final void Function(HSLColor, HSLColor) onTap;
  final Function() onDelete;

  FavColorTile({
    @required this.light,
    @required this.dark,
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
          onTap: () => onTap(light, dark),
          onLongPress: onDelete,
          borderRadius: BorderRadius.circular(size / 2),
          child: Row(
            children: <Widget>[
              Container(
                height: size,
                width: size / 2,
                decoration: BoxDecoration(
                  color: light.toColor(),
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
                  color: dark.toColor(),
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