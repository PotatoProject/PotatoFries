import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/widgets/page_parser.dart';

class LockScreen extends BasePage {
  @override
  String get title => LocaleStrings.lockscreen.title;

  @override
  IconData get icon => CustomIcons.screen_lock_portrait;

  @override
  String get providerKey => "lock_screen";

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
