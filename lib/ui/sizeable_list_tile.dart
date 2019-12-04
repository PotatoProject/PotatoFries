import 'package:flutter/material.dart';

class SizeableListTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: height != null ?
            height :
            subtitle != null ?
                60 :
                null,
        width: width ?? null,
        color: backgroundColor ?? null,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: icon,
              onPressed: null,
              disabledColor:
                  selected ? selectedColor : elementsColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: selected
                          ? selectedColor
                          : elementsColor,
                    ),
                  ),
                  Visibility(
                    visible: subtitle != null,
                    child: Text(
                      subtitle ?? "",
                      style: TextStyle(
                        color: selected
                            ? selectedColor.withAlpha(160)
                            : elementsColor.withAlpha(160),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
