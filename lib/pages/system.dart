import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';

class System extends BasePage {
  @override
  String get title => LocaleStrings.system.title;

  @override
  IconData get icon => Icons.android;

  @override
  String get providerKey => 'system';
}
