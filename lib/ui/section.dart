import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  Color color;
  final bool showDivider;
  final List<Widget> children;

  Section({
    @required this.title,
    this.color,
    this.showDivider = true,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      color = Theme.of(context).accentColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: showDivider,
          child: Divider(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children ?? [Container()],
        ),
      ],
    );
  }
}
