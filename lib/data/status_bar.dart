import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'Battery': statusbarbattery,
};

final Map<String, dynamic> statusbarbattery = {
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
