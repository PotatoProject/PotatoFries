import 'package:flutter/material.dart';

class SizeableListTile extends StatelessWidget {
  final double height;
  final double width;
  final Widget icon;
  final Widget trailing;
  final dynamic title;
  final Widget subtitle;
  final String footer;
  final bool selected;
  final Color backgroundColor;
  final Color elementsColor;
  final Color selectedColor;
  final Function() onTap;

  SizeableListTile({
    this.height,
    this.width,
    this.icon,
    this.trailing,
    @required this.title,
    this.subtitle,
    this.footer,
    this.selected = false,
    this.selectedColor,
    this.backgroundColor,
    this.elementsColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var _elementsColor =
        elementsColor ?? Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
    
    var _selectedColor =
        selectedColor ?? Theme.of(context).accentColor;

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
                child: icon ?? Container(width: 24),
                data: IconThemeData(
                  color: selected ? _selectedColor : _elementsColor,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 0, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title is String
                        ? Text(
                            title,
                            style: TextStyle(
                              letterSpacing: 0.3,
                              fontSize: 16,
                              color: selected ? _selectedColor : _elementsColor,
                            ),
                          )
                        : title,
                    Visibility(
                      visible: subtitle != null,
                      child: DefaultTextStyle(
                        child: subtitle ?? Container(),
                        style: TextStyle(
                          color: selected
                              ? _selectedColor.withAlpha(160)
                              : _elementsColor.withAlpha(160),
                          fontSize: 13,
                        ),
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
                                  ? _selectedColor.withAlpha(160)
                                  : _elementsColor.withAlpha(160),
                              fontSize: 13,
                            ),
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
              child: trailing ?? Container(),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
