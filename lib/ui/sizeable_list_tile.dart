import 'package:flutter/material.dart';

class SizeableListTile extends StatelessWidget {
  Key key;
  double height;
  double width;
  Widget icon;
  String title;
  String subtitle;
  String footer;
  String headerAncestor;
  bool selected;
  Color backgroundColor;
  Color elementsColor;
  Color selectedColor;
  Function() onTap;

  SizeableListTile({
    this.key,
    this.height,
    this.width,
    @required this.icon,
    @required this.title,
    this.subtitle,
    this.footer,
    this.headerAncestor,
    this.selected = false,
    this.selectedColor,
    this.backgroundColor,
    this.elementsColor,
    this.onTap,
  }) : assert(
         footer == null && headerAncestor != null ||
         footer != null && headerAncestor == null
       ),
       super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if(elementsColor == null) {
      elementsColor = Theme.of(context).brightness == Brightness.light ?
          Colors.black :
          Colors.white;
    }
    
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: icon == null ? 8 : 16),
        height: height,
        width: width ?? null,
        color: backgroundColor ?? null,
        child: Row(
          children: <Widget>[
            Container(
              margin: icon == null ?
                  null :
                  EdgeInsets.fromLTRB(8, 8, 16, 8),
              child: IconTheme(
                child: icon ?? Container(),
                data: IconThemeData(
                  color: selected ? selectedColor : elementsColor
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 12, 0, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      letterSpacing: 0.3,
                      fontSize: 16,
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
                        fontSize: 13
                      ),
                    ),
                  ),
                  Visibility(
                    visible: footer != null,
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 10,
                          color: Colors.transparent,
                        ),
                        Text(
                          footer ?? "",
                          style: TextStyle(
                            color: selected
                                ? selectedColor.withAlpha(160)
                                : elementsColor.withAlpha(160),
                            fontSize: 13
                          ),
                        ),
                      ],
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
