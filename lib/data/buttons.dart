import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> buttons = {
  'System Buttons': sysbutton,
  'System Gestures': systemgesture,
};

final Map<String, dynamic> sysbutton = {
  'volume_button_music_control': {
    'title': 'Volume button to skip tracks',
    'subtitle':'Long press volume buttons to forward/backward track',
    'icon': Icons.music_note,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    }
  },
};

final Map<String, dynamic> systemgesture = {
  'double_tap_sleep_gesture': {
    'title': 'Double tap Status bar to sleep',
    'subtitle':'Tap twice on Status bar to put device in sleep',
    'icon': Icons.touch_app,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    }
  },
};
