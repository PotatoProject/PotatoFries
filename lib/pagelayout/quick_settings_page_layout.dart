import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/pagelayout/page_layout.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:potato_fries/ui/section_header.dart';
import 'package:potato_fries/widgets/settings_slider_tile.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';
import 'package:provider/provider.dart';

class QuickSettingsPageLayout extends PageLayout {
  @override
  int get categoryIndex => 0;

  @override
  List<Widget> body(BuildContext context, {BaseDataProvider provider}) => [
    SectionHeader(
              title: "Colors",
            ),
            SettingsSwitchTile(
              icon: Icon(Icons.settings_backup_restore),
              setting: 'qs_panel_bg_use_fw',
              type: SettingType.SYSTEM,
              provider: provider,
              title: 'Use framework values for QS',
              subtitle: 'Disable QS colors and use framework values',
              headerAncestor: "Colors",
            ),
            SettingsSwitchTile(
              icon: Icon(Icons.colorize),
              setting: 'qs_panel_bg_use_wall',
              type: SettingType.SYSTEM,
              provider: provider,
              title: 'Use wallpaper colors',
              subtitle: 'Dynamically choose colors from the wallpaper',
              headerAncestor: "Colors",
            ),
            SettingsSliderTile(
              setting: 'qs_panel_bg_alpha',
              type: SettingType.SYSTEM,
              min: 100,
              max: 255,
              title: 'QS Panel Opacity',
              provider: provider,
              headerAncestor: "Colors",
            ),
  ];
}