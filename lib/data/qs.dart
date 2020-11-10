import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> qsData = {
  'Quick settings tweaks': qstweaks,
};

final Map<String, dynamic> qstweaks = {
  'status_bar_quick_qs_pulldown': {
    'title': 'Quick QS pulldown',
    'icon': Icons.add_road_outlined,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
'widget_data': {
  'values': {
    '0': 'Disabled',
    '1': 'Pulldown statusbar from right side',
    '2': 'Pulldown statusbar from left side',
  },
},
    'version': '4.0.0',
  },
  'qs_show_auto_brightness': {
    'title': 'Autobrightness icon',
    'subtitle': 'Show auto brightness icon near the slider',
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
    'icon': Icons.brightness_6,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Never show',
        '1': 'Show when QS panel is expanded',
        '2': 'Show always',
      },
      'version': '4.0.0',
    },
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
      'default': 3,
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
