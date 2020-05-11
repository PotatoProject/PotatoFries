import 'package:potato_fries/widgets/directory.dart';
import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';

final Map<String, dynamic> themeData = {
  'Accent': themeAccent,
  'Themes': theme,
};

final Map<String, dynamic> themeAccent = {
  'system_accent': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'AccentPicker',
  },
  'system_icon_shape': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconShapePicker',
  },
  'system_icon_pack': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconPackPicker',
  },
};

final Map<String, dynamic> theme = {
'color_bucket_overlay': {
  'title': 'Theme' ,
  'icon': Icons.format_color_text ,
  'widget': WidgetType.DROPDOWN ,
  'setting_type': SettingType.SYSTEM ,
  'widget_data': {
    'values': {
      'package_device_default': 'Default theme',
      'com.android.dark.darkgray': 'Dark',
      'com.android.dark.night': 'Night',
      'com.android.dark.style': 'Style',
    },
'default':'package_device_default',
  },
},
};
