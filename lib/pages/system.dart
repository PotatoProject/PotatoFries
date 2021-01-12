import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/base_page.dart';

class System extends BasePage {
  @override
  String get title => LocaleStrings.system.title;

  @override
  IconData get icon => MdiIcons.android;

  @override
  String get providerKey => 'system';
}
