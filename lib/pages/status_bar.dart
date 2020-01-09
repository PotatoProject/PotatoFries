import 'package:flutter/material.dart';
import 'package:potato_fries/provider/status_bar.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatelessWidget {
  final StatusBarDataProvider provider = StatusBarDataProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: _StatusBarBody(),
    );
  }
}

class _StatusBarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Status Bar'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        _header(context),
        PageParser(dataKey: 'status_bar'),
      ],
    );
  }

  Widget _header(BuildContext context) => Container();
}
