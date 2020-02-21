import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> misc = {
  'Signature spoofing': spoofing,
};

final Map<String, dynamic> spoofing = {
  'allow_signature_fake': {
    'title': 'Toggle signature spoofing',
    'subtitle': 'Allow fake signatures',
    'icon': Icons.format_color_text,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.GLOBAL,
    'widget_data': {
      'default': true,
    }
  },
};
