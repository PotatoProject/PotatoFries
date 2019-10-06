import 'package:flutter/material.dart';

class SizeableListTile extends StatefulWidget {
  double height;
  double width;
  Widget icon;
  String title;
  Color backgroundColor;
  Color elementsColor;
  Function() onTap;

  SizeableListTile({
    this.height,
    this.width,
    @required this.icon,
    @required this.title,
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
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: widget.height ?? null,
        width: widget.width ?? null,
        color: widget.backgroundColor ?? null,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: widget.icon,
              onPressed: null,
              disabledColor: widget.elementsColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                widget.title,
                style: TextStyle(
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                  color: widget.elementsColor,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}