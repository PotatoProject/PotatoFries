import 'package:flutter/material.dart';
import 'package:potato_fries/provider/lock_screen.dart';
import 'package:potato_fries/provider/misc.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class Misc extends StatelessWidget {
  final MiscDataProvider provider = MiscDataProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: _LockScreenBody(),
    );
  }
}

class _LockScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Miscellaneous'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        _header(context),
        PageParser(dataKey: 'misc'),
      ],
    );
  }

  Widget _header(BuildContext context) => Container();
}
