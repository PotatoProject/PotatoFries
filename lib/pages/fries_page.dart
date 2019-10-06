import 'package:flutter/material.dart';

class FriesPage extends StatelessWidget {
  final String title;
  final List<Widget> children;

  FriesPage({
    @required this.children,
    @required this.title,
  })  : assert(children != null),
        assert(title != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Container(
              padding: EdgeInsets.only(bottom: 64),
              child: ListView(children: children),
            ),
          ),
        ),
      ],
    );
  }
}
