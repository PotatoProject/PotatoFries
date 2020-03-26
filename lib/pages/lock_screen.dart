import 'package:flutter/material.dart';
import 'package:potato_fries/provider/lock_screen.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class LockScreen extends StatelessWidget {
  final LockScreenDataProvider provider = LockScreenDataProvider();

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
        _header(context),
        PageParser(dataKey: 'lock_screen'),
      ],
    );
  }

  Widget _header(BuildContext context) => Container();
}
