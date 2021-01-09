import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final Map<String, List<Preference>> statusBar = {
  LocaleStrings.statusbar.cutoutsTitle: displayCutouts,
  LocaleStrings.statusbar.batteryTitle: statusBarBattery,
};

final List<Preference> displayCutouts = [
  SettingPreference.withDropdown(
    setting: 'display_cutout_mode',
    title: LocaleStrings.statusbar.cutoutsDisplayCutoutModeTitle,
    icon: SmartIconData.iconData(Icons.aspect_ratio),
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        '0': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV0,
        '1': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV1,
        // '2': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV2,
      },
      defaultValue: '0',
    ),
    dependencies: [
      PropDependency(
        name: 'ro.potato.has_cutout',
        value: true,
      ),
    ],
    minVersion: '4.0.0',
  ),
  // SettingPreference.withSwitch(
  //   setting: 'sysui_rounded_size',
  //   icon: SmartIconData.iconData(MdiIcons.arrowUpDown),
  //   title: 'Stock Statusbar in Hide',
  //   description: 'Use default (usually smaller) statusbar height in hide',
  //   type: SettingType.SYSTEM,
  //   options: SwitchOptions(
  //     defaultValue: true,
  //   ),
  //   dependencies: [
  //     SettingDependency.string(name: 'display_cutout_mode', type: SettingType.SYSTEM, value: '2',),
  //     PropDependency(
  //       name: 'ro.potato.has_cutout',
  //       value: true,
  //     ),
  //   ],
  //   minVersion: '4.0.0',
  // ),
  SettingPreference.withSlider(
    setting: 'sysui_rounded_size',
    title: LocaleStrings.statusbar.cutoutsSysuiRoundedSizeTitle,
    type: SettingType.SECURE,
    options: SliderOptions(
      defaultValue: -1,
      max: 50,
    ),
    minVersion: '4.0.0',
  ),
];

final List<Preference> statusBarBattery = [
  SettingPreference.withDropdown(
    setting: 'status_bar_battery_style',
    title: LocaleStrings.statusbar.batteryStatusBarBatteryStyleTitle,
    icon: SmartIconData.iconData(Icons.battery_full),
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        '0': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV0,
        '1': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV1,
        '2': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV2,
        '3': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV3,
        '4': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV4,
        '5': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV5,
      },
      defaultValue: '0',
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withDropdown(
    setting: 'status_bar_show_battery_percent',
    title: LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentTitle,
    icon: SmartIconData.iconData(MdiIcons.percent),
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        '0': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentV0,
        '1': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentV1,
        '2': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentV2,
      },
      defaultValue: '0',
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSwitch(
    setting: 'qs_header_show_battery_percent',
    title: LocaleStrings.statusbar.batteryQsHeaderShowBatteryPercentTitle,
    description: LocaleStrings.statusbar.batteryQsHeaderShowBatteryPercentDesc,
    icon: SmartIconData.iconData(Icons.battery_std),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.0',
  ),
];
