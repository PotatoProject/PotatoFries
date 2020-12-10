import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> qsData = {
  'Quick settings tweaks': qstweaks,
};

final Map<String, dynamic> qstweaks = {
  'qs_show_auto_brightness': {
    'title': 'QS Auto brightness',
    'subtitle': 'Show auto brightness icon on QS panel',
    'icon': Icons.brightness_6,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
  'qs_show_brightness_slider': {
    'title': 'Brightness slider',
    'subtitle': 'Show a brightness slider in the quick settings panel',
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Never show',
        '1': 'Show when expanded',
        '2': 'Show always',
      },
      'default': '1',
    },
    'version': '4.0.0',
  },
  'qs_tile_title_visibility': {
    'title': 'Show title of QS tiles',
    'subtitle': 'Hide or show title of QS tiles',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
  'qs_rows_portrait': {
    'title': 'Tiles rows on portrait',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 2,
      'min': 1,
      'max': 5,
      'percentage': false,
    },
    'version': '4.0.0',
  },
  'qs_columns_portrait': {
    'title': 'Tiles columns on portrait',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 3,
      'min': 1,
      'max': 7,
      'percentage': false,
    },
    'version': '4.0.0',
  },
  'qs_rows_landscape': {
    'title': 'Tiles rows on landscape',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 1,
      'min': 1,
      'max': 5,
      'percentage': false,
    },
    'version': '4.0.0',
  },
  'qs_columns_landscape': {
    'title': 'Tiles columns on landscape',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 4,
      'min': 1,
      'max': 9,
      'percentage': false,
    },
    'version': '4.0.0',
  },
};
