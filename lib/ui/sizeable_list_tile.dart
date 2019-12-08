import 'package:flutter/material.dart';

class SizeableListTile extends StatelessWidget {
  Key key;
  double height;
  double width;
  Widget icon;
  Widget trailing;
  String title;
  Widget subtitle;
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
    this.icon,
    this.trailing,
    @required this.title,
    this.subtitle,
    this.footer,
    this.headerAncestor,
    this.selected = false,
    this.selectedColor,
    this.backgroundColor,
    this.elementsColor,
    this.onTap,
  })  : assert(footer == null && headerAncestor != null ||
            footer != null && headerAncestor == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (elementsColor == null) {
      elementsColor = Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white;
    }

    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: height,
        width: width ?? null,
        color: backgroundColor ?? null,
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: IconTheme(
                  child: icon ??
                      Container(
                        width: 24,
                      ),
                  data: IconThemeData(
                      color: selected ? selectedColor : elementsColor),
                )),
            Expanded(
              child: Padding(
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
                        color: selected ? selectedColor : elementsColor,
                      ),
                    ),
                    Visibility(
                      visible: subtitle != null,
                      child: DefaultTextStyle(
                        child: subtitle ?? Container(),
                        style: TextStyle(
                            color: selected
                                ? selectedColor.withAlpha(160)
                                : elementsColor.withAlpha(160),
                            fontSize: 13),
                      ),
                    ),
                    Visibility(
                      visible: footer != null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin:
                    trailing == null ? null : EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: trailing ?? Container()),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
