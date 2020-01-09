import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> buttons = {
  'Notifications': notif,
};

final Map<String, dynamic> notif = {
  'notification_sound_vib_screen_on':{
    'title': 'Notification sound if active',
    'subtitle': 'Play sound and vibration for notifications when screen is on',
    'widget' : WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
        'widget_data': {
      'default': true,
    }

  },
};
