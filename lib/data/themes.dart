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
};
