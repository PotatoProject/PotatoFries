import 'package:flutter/material.dart';

class SizeableListTile extends StatefulWidget {
  double height;
  double width;
  Widget icon;
  String title;
  String subtitle;
  bool selected;
  Color backgroundColor;
  Color elementsColor;
  Color selectedColor;
  Function() onTap;

  SizeableListTile({
    this.height,
    this.width,
    @required this.icon,
    @required this.title,
    this.subtitle,
    this.selected = false,
    this.selectedColor,
    this.backgroundColor,
    this.elementsColor,
    @required this.onTap,
  });

  @override
  createState() => _SizeableListTileState();
}

class _SizeableListTileState extends State<SizeableListTile> {
  @override
  Widget build(BuildContext context) {
    print(widget.subtitle != null);
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: widget.height != null ?
            widget.height :
            widget.subtitle != null ?
                60 :
                null,
        width: widget.width ?? null,
        color: widget.backgroundColor ?? null,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: widget.icon,
              onPressed: null,
              disabledColor:
                  widget.selected ? widget.selectedColor : widget.elementsColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: widget.selected
                          ? widget.selectedColor
                          : widget.elementsColor,
                    ),
                  ),
                  Visibility(
                    visible: widget.subtitle != null,
                    child: Text(
                      widget.subtitle ?? "",
                      style: TextStyle(
                        color: widget.selected
                            ? widget.selectedColor.withAlpha(160)
                            : widget.elementsColor.withAlpha(160),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
