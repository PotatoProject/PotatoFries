import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> qsData = {
  'Colors': qsColors,
  'Quick settings tweaks': qstweaks,
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
    },
    'dependencies': [
      {
        'name': 'qs_panel_bg_use_fw',
        'setting_type': SettingType.SYSTEM,
        'value': false,
      },
    ]
  },
  'qs_panel_bg_alpha': {
    'title': 'QS Panel Opacity',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 255,
      'min': 100,
      'max': 255,
      'percentage': false,
    },
    'dependencies': [
      {
        'name': 'qs_panel_bg_use_fw',
        'setting_type': SettingType.SYSTEM,
        'value': false,
      },
    ],
  },
  'qs_panel_bg_color': {
    'title': 'Pick QS background color',
    'subtitle': 'Choose your favorite color!',
    'widget': WidgetType.COLOR_PICKER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      // TODO: Fix this in framework, do something smarter about this default
      'default': Colors.transparent,
      'lightness_min': 0.0,
      'lightness_max': 0.6,
      'unset_preview': true,
    },
    'dependencies': [
      {
        'name': 'qs_panel_bg_use_fw',
        'setting_type': SettingType.SYSTEM,
        'value': false,
      },
      {
        'name': 'qs_panel_bg_use_wall',
        'setting_type': SettingType.SYSTEM,
        'value': false,
      },
    ],
  },
};

final Map<String, dynamic> qstweaks = {
  'qs_tile_title_visibility': {
    'title': 'Show title of QS tiles',
    'subtitle': 'Hide or show title of QS tiles',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.5',
  },
  'qs_rows_portrait': {
    'title': 'Tiles rows on portrait',
    'icon': Icons.crop_portrait,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 3,
      'min': 1,
      'max': 5,
      'percentage': false,
    },
    'version': '3.1.5',
  },
  'qs_columns_portrait': {
    'title': 'Tiles columns on portrait',
    'icon': Icons.crop_portrait,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 3,
      'min': 1,
      'max': 7,
      'percentage': false,
    },
    'version': '3.1.5',
  },
  'qs_rows_landscape': {
    'title': 'Tiles rows on landscape',
    'icon': Icons.crop_portrait,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 1,
      'min': 1,
      'max': 5,
      'percentage': false,
    },
    'version': '3.1.5',
  },
  'qs_columns_landscape': {
    'title': 'Tiles columns on landscape',
    'icon': Icons.crop_portrait,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 4,
      'min': 1,
      'max': 9,
      'percentage': false,
    },
    'version': '3.1.5',
  },
};
