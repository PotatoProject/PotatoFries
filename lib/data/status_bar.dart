import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'Display Cutouts': displayCutouts,
  'Battery': statusBarBattery,
};

final Map<String, dynamic> displayCutouts = {
  'display_cutout_mode': {
    'title': 'Cutout mode',
    'icon': Icons.aspect_ratio,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Normal',
        '1': 'Immerse',
        // '2': 'Hide',
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
    'title': 'Rounded corner radius',
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
    'title': 'Battery Style',
    'icon': Icons.battery_full,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Portrait',
        '1': 'Circle',
        '2': 'Dotted Circle',
        '3': 'Solid Circle',
        '4': 'Text',
        '5': 'Hidden',
      },
      'default': '0',
    },
    'version': '4.0.0',
  },
  'status_bar_show_battery_percent': {
    'title': 'Battery Percentage',
    'icon': MdiIcons.percent,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Hidden',
        '1': 'Inside the icon',
        '2': 'Next to the icon',
      },
      'default': '0',
    },
    'version': '4.0.0',
  },
  'qs_header_show_battery_percent':{
    'title': 'QS battery percentage',
    'subtitle': 'Show battery percentage in the QS header instead of estimate',
    'icon': Icons.battery_std,
    'widget':WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
};
