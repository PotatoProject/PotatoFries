import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:android_flutter_settings/android_flutter_settings.dart';

final PageData themes = PageData(
  key: 'themes',
  categories: [
    // PageCategoryData(LocaleStrings.themes.themesTitle, theme),
  ],
);

final List<Preference> theme = [
  // CustomPreference(id: 'AccentPicker'),
  // SettingPreference.withSwitch(
  //   setting: 'sysui_colors_active',
  //   title: LocaleStrings.themes.themesSysuiColorsActiveTitle,
  //   description: LocaleStrings.themes.themesSysuiColorsActiveDesc,
  //   icon: SmartIconData.iconData(MdiIcons.selectColor),
  //   type: SettingType.SYSTEM,
  //   options: SwitchOptions(
  //     defaultValue: true,
  //   ),
  //   minVersion: '4.1.2',
  // ),
  // CustomPreference(id: 'IconShapePicker'),
  // CustomPreference(id: 'IconPackPicker'),
];