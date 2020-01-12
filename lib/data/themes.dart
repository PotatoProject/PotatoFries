import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> themeData = {
  'Accent': themeAccent,
};

final Map<String, dynamic> themeAccent = {
  'system_accent': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'AccentPicker',
  },
  'qs_panel_bg_use_fw': {
    'title': 'Use framework values for QS',
    'subtitle': 'Disable QS colors and use framework values',
    'icon': Icons.settings_backup_restore,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Off',
        '1': 'On',
      },
    },
  },
};
