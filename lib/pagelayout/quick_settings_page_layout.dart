import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/pagelayout/page_layout.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:potato_fries/ui/color_picker_tile.dart';
import 'package:potato_fries/ui/section.dart';
import 'package:potato_fries/widgets/settings_slider_tile.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';

class QuickSettingsPageLayout extends PageLayout {
  @override
  int get categoryIndex => 0;

  @override
  List<Widget> body(BuildContext context, {BaseDataProvider provider}) => [
        Section(
          title: "Colors",
          children: <Widget>[
            SettingsSwitchTile(
              icon: Icon(Icons.settings_backup_restore),
              setting: 'qs_panel_bg_use_fw',
              type: SettingType.SYSTEM,
              provider: provider,
              title: 'Use framework values for QS',
              subtitle: 'Disable QS colors and use framework values',
            ),
            SettingsSwitchTile(
              icon: Icon(Icons.colorize),
              setting: 'qs_panel_bg_use_wall',
              type: SettingType.SYSTEM,
              provider: provider,
              title: 'Use wallpaper colors',
              subtitle: 'Dynamically choose colors from the wallpaper',
            ),
            SettingsSliderTile(
              setting: 'qs_panel_bg_alpha',
              type: SettingType.SYSTEM,
              min: 100,
              max: 255,
              title: 'QS Panel Opacity',
              provider: provider,
              percentage: true,
            ),
            ColorPickerTile(
              title: 'QS Background color',
              subtitle: 'Pick your favourite color!',
              defaultColor: Color(
                (provider as QSDataProvider)?.extraData == null
                    ? 0xFF000000
                    : (provider as QSDataProvider)?.extraData[
                            '${SettingType.SYSTEM.toString()}/qs_panel_bg_color'] ??
                        0xFF000000,
              ),
              onApply: (String newDark, String newLight) {
                var qsProvider = provider as QSDataProvider;
                int colorVal = int.parse('0xff' + newDark);
                qsProvider.extraData[
                        '${SettingType.SYSTEM.toString()}/qs_panel_bg_color'] =
                    colorVal;
                AndroidFlutterSettings.putInt(
                  'qs_panel_bg_color',
                  colorVal,
                  SettingType.SYSTEM,
                );
                qsProvider.extraData = qsProvider.extraData;
              },
            ),
          ],
        ),
      ];
}
