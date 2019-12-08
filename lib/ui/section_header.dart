import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  String title;
  Color color;
  bool showDivider;

  SectionHeader({
    @required this.title,
    this.color,
    this.showDivider = true,
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
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
