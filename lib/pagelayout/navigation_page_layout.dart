import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/pagelayout/page_layout.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/section_header.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';

class NavigationPageLayout extends PageLayout {
  @override
  int get categoryIndex => 1;

  @override
  List<Widget> body(BuildContext context, {BaseDataProvider provider}) => [
    SectionHeader(
      title: "Yeet",
    ),
    SettingsSwitchTile(
      title: 'Airplane mode enabled',
      type: SettingType.GLOBAL,
      setting: 'airplane_mode_on',
      headerAncestor: "Yeet",
    ),
  ];
}