import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> lockScreen = {
  'Lockscreen Stuff': lsstuff,
};

final Map<String, dynamic> lsstuff = {
  'lockscreen_media_metadata': {
    'title': 'Lockscreen media art',
    'subtitle': 'Show album art on lockscreen',
    'icon': Icons.image,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.1',
  },
};
