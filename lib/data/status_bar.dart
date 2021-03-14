import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final PageData statusBar = PageData(
  key: 'status_bar',
  categories: [
    PageCategoryData(LocaleStrings.statusbar.cutoutsTitle, displayCutouts),
    PageCategoryData(LocaleStrings.statusbar.iconsTitle, statusBarIcons),
    PageCategoryData(LocaleStrings.statusbar.nettrafficTitle, netTraffic),
    PageCategoryData(LocaleStrings.statusbar.batteryTitle, statusBarBattery),
  ],
);

final List<Preference> displayCutouts = [
  SettingPreference.withDropdown(
    setting: 'display_cutout_mode',
    title: LocaleStrings.statusbar.cutoutsDisplayCutoutModeTitle,
    icon: SmartIconData.iconData(CustomIcons.notch),
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        '0': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV0,
        '1': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV1,
        '2': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV2,
      },
      defaultValue: '0',
    ),
    dependencies: [
      PropDependency(
        name: 'ro.potato.has_cutout',
        value: 'true',
      ),
    ],
    minVersion: '4.0.0',
  ),
  SettingPreference.withSwitch(
    setting: 'stock_statusbar_in_hide',
    icon: SmartIconData.iconData(MdiIcons.arrowUpDown),
    title: LocaleStrings.statusbar.cutoutsStockStatusbarInHideTitle,
    description: LocaleStrings.statusbar.cutoutsStockStatusbarInHideDesc,
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    dependencies: [
      SettingDependency.string(name: 'display_cutout_mode', type: SettingType.SYSTEM, value: '2',),
      PropDependency(
        name: 'ro.potato.has_cutout',
        value: 'true',
      ),
    ],
    minVersion: '4.0.0',
  ),
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

final List<Preference> statusBarIcons = [
  SettingPreference.withSwitch(
    setting: 'show_fourg_icon',
    title: LocaleStrings.statusbar.iconsShowFourgIconTitle,
    description: LocaleStrings.statusbar.iconsShowFourgIconDesc,
    icon: SmartIconData.iconData(Icons.signal_cellular_4_bar),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.2',
  ),
  SettingPreference.withSwitch(
    setting: 'show_volte_icon',
    title: LocaleStrings.statusbar.iconsShowVolteIconTitle,
    description: LocaleStrings.statusbar.iconsShowVolteIconDesc,
    icon: SmartIconData.iconData(Icons.hd),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.2',
  ),
  SettingPreference.withSwitch(
    setting: 'roaming_indicator_icon',
    title: LocaleStrings.statusbar.iconsRoamingIndicatorIconTitle,
    description: LocaleStrings.statusbar.iconsRoamingIndicatorIconDesc,
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.2',
  ),
  ActivityPreference(
    title: LocaleStrings.statusbar.iconsSystemuiTunerStatusbarTitle,
    description: LocaleStrings.statusbar.iconsSystemuiTunerStatusbarDesc,
    cls: "com.android.systemui.tuner.StatusbarItemsActivity",
    pkg: "com.android.systemui",
    minVersion: '4.0.2',
  ),
];

final List<Preference> netTraffic = [
  SettingPreference.withDropdown(
    setting:'network_traffic_location',
    title: LocaleStrings.statusbar.nettrafficNetworkTrafficLocationTitle,
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        '0' : LocaleStrings.statusbar.nettrafficNetworkTrafficLocationV0,
        '1' : LocaleStrings.statusbar.nettrafficNetworkTrafficLocationV1,
        '2' : LocaleStrings.statusbar.nettrafficNetworkTrafficLocationV2,
      },
      defaultValue: '0',
    ),
      minVersion : '4.0.6'
  ),
  SettingPreference.withDropdown(
      setting:'network_traffic_unit_type',
      title: LocaleStrings.statusbar.nettrafficNetworkTrafficUnitTypeTitle,
      type: SettingType.SYSTEM,
      options: DropdownOptions(
        values: {
          '0' : LocaleStrings.statusbar.nettrafficNetworkTrafficUnitTypeV0,
          '1' : LocaleStrings.statusbar.nettrafficNetworkTrafficUnitTypeV1,
        },
        defaultValue: '0',
      ),
      minVersion : '4.0.6'
  ),
  SettingPreference.withSwitch(
    setting: 'network_traffic_autohide',
    title: LocaleStrings.statusbar.nettrafficNetworkTrafficAutohideTitle,
    description: LocaleStrings.statusbar.nettrafficNetworkTrafficAutohideDesc,
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.6',
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

