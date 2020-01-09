import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> lockScreen = {
  'Lockscreen Media': lsart,
};

final Map<String, dynamic> lsart = {
  'lockscreen_media_metadata': {
    'title': 'Lockscreen Media Art',
    'subtitle': 'Show Album Art on lockscreen',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    }
  },
};
