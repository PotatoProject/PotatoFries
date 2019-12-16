import 'package:flutter/material.dart';

class FavColorTile extends StatefulWidget {
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
  _FavColorTileState createState() => _FavColorTileState();
}

class _FavColorTileState extends State<FavColorTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox.fromSize(
            size: Size.square(widget.size),
            child: InkWell(
                onTap: () => widget.onTap(
                    widget.base, widget.lightLightness, widget.darkLightness),
                onLongPress: widget.onDelete,
                borderRadius: BorderRadius.circular(widget.size / 2),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: widget.size,
                      width: widget.size / 2,
                      decoration: BoxDecoration(
                        color: widget.base
                            .withLightness(widget.lightLightness)
                            .toColor(),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(widget.size / 2),
                            bottomLeft: Radius.circular(widget.size / 2)),
                      ),
                    ),
                    Container(
                      height: widget.size,
                      width: widget.size / 2,
                      decoration: BoxDecoration(
                        color: widget.base
                            .withLightness(widget.darkLightness)
                            .toColor(),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(widget.size / 2),
                            bottomRight: Radius.circular(widget.size / 2)),
                      ),
                    ),
                  ],
                ))));
  }
}
