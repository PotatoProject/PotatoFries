import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/ui/custom_icons.dart';

class LockScreen extends BasePage {
  @override
  String get title => LocaleStrings.lockscreen.title;

  @override
  IconData get icon => CustomIcons.lock_screen;

  @override
  String get providerKey => "lock_screen";
}
