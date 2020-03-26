import 'package:flutter/material.dart';
import 'package:potato_fries/provider/buttons.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class Buttons extends StatelessWidget {
  final ButtonsDataProvider provider = ButtonsDataProvider();

  @override
  Widget build(BuildContext context) {
    print("buttons");
    return ChangeNotifierProvider.value(
      value: provider,
      child: _ButtonsBody(),
    );
  }
}

class _ButtonsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Buttons and Gestures'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        _header(context),
        PageParser(dataKey: 'buttons_and_gestures'),
      ],
    );
  }

  Widget _header(BuildContext context) => Container();
}
