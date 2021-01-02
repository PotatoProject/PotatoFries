import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  LocaleStrings.statusbar.cutoutsTitle: displayCutouts,
  LocaleStrings.statusbar.batteryTitle: statusBarBattery,
};

final Map<String, dynamic> displayCutouts = {
  'display_cutout_mode': {
    'title': LocaleStrings.statusbar.cutoutsDisplayCutoutModeTitle,
    'icon': Icons.aspect_ratio,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV0,
        '1': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV1,
        // '2': LocaleStrings.statusbar.cutoutsDisplayCutoutModeV2,
      },
      'default': '0',
    },
    'compat': {
      'prop': 'ro.potato.has_cutout',
    },
    'version': '4.0.0',
  },
  // 'stock_statusbar_in_hide': {
  //   'title': 'Stock Statusbar in Hide',
  //   'subtitle': 'Use default (usually smaller) statusbar height in hide',
  //   'icon': MdiIcons.arrowUpDown,
  //   'widget': WidgetType.SWITCH,
  //   'setting_type': SettingType.SYSTEM,
  //   'widget_data': {
  //     'default': true,
  //   },
  //   'compat': {
  //     'prop': 'ro.potato.has_cutout',
  //   },
  //   'dependencies': [
  //     {
  //       'name': 'display_cutout_mode',
  //       'setting_type': SettingType.SYSTEM,
  //       'value': '2',
  //     },
  //   ],
  //   'version': '4.0.0',
  // },

  'sysui_rounded_size': {
    'title': LocaleStrings.statusbar.cutoutsSysuiRoundedSizeTitle,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': -1,
      'min': 0,
      'max': 50,
      'percentage': false,
    },
    'version': '4.0.0',
  },
};

final Map<String, dynamic> statusBarBattery = {
  'status_bar_battery_style': {
    'title': LocaleStrings.statusbar.batteryStatusBarBatteryStyleTitle,
    'icon': Icons.battery_full,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV0,
        '1': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV1,
        '2': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV2,
        '3': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV3,
        '4': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV4,
        '5': LocaleStrings.statusbar.batteryStatusBarBatteryStyleV5,
      },
      'default': '0',
    },
    'version': '4.0.0',
  },
  'status_bar_show_battery_percent': {
    'title': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentTitle,
    'icon': MdiIcons.percent,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentV0,
        '1': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentV1,
        '2': LocaleStrings.statusbar.batteryStatusBarShowBatteryPercentV2,
      },
      'default': '0',
    },
    'version': '4.0.0',
  },
  'qs_header_show_battery_percent': {
    'title': LocaleStrings.statusbar.batteryQsHeaderShowBatteryPercentTitle,
    'subtitle': LocaleStrings.statusbar.batteryQsHeaderShowBatteryPercentDesc,
    'icon': Icons.battery_std,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
};
