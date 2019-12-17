import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> qsData = {
  'Colors': qsColors,
};

final Map<String, dynamic> qsColors = {
  'qs_panel_bg_use_fw': {
    'title': 'Use framework values for QS',
    'subtitle': 'Disable QS colors and use framework values',
    'icon': Icons.settings_backup_restore,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    }
  },
  'qs_panel_bg_use_wall': {
    'title': 'Use wallpaper colors',
    'subtitle': 'Dynamically choose colors from the wallpaper',
    'icon': Icons.colorize,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    }
  },
  'qs_panel_bg_alpha': {
    'title': 'QS Panel Opacity',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
      'min': 100,
      'max': 255,
      'percentage': false,
    }
  },
  'qs_panel_bg_color': {
    'title': 'Pick QS background color',
    'subtitle': 'Choose your favorite color!',
    'widget': WidgetType.COLOR_PICKER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {}
  },
};
