import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'Our icons': sbicon,
};

final Map<String, dynamic> sbicon = {
  'status_bar_logo': {
    'title': 'POSP icon in statusbar',
    'subtitle': 'Let everyone know you are using POSP',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    }
  },
};
