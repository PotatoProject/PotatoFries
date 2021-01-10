import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/page_parser.dart';

abstract class BasePage extends StatelessWidget {
  String get title;
  IconData get icon;
  String get providerKey;

  @override
  Widget build(BuildContext context) {
    final _header = buildHeader(context);
    return Column(
      children: [
        _header ?? Container(),
        Expanded(
          child: PageParser(
            dataKey: providerKey,
            useTopPadding: _header == null,
          ),
        ),
      ],
    );
  }

  Widget buildHeader(BuildContext context) => null;
}
