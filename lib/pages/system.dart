import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/widgets/page_parser.dart';

class System extends BasePage {
  @override
  String get title => LocaleStrings.system.title;

  @override
  IconData get icon => Icons.android;

  @override
  String get providerKey => 'system';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(),
        PageParser(dataKey: providerKey),
      ],
    );
  }
}
