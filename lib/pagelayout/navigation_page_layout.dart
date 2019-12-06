import 'package:flutter/material.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/pagelayout/page_layout.dart';
import 'package:potato_fries/ui/section_header.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';

class NavigationPageLayout extends PageLayout {
  @override
  int get categoryIndex => 1;

  @override
  List<Widget> body(BuildContext context) => [
    SectionHeader(
      title: "Cool category",
    ),
    SettingsSwitchTile(
      title: 'Cool setting',
      type: SettingType.SYSTEM,
      setting: 'cool_setting',
      headerAncestor: "Cool category",
    ),
  ];
}