import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> buttons = {
  'System Buttons': sysbutton,
  'System Gestures': systemgesture,
};

final Map<String, dynamic> systemgesture = {
  'double_tap_sleep_lockscreen': {
    'title': 'Double tap to sleep on losckreen',
    'subtitle': 'Double tap on lockscreen empty areas to switch the screen off',
    'icon': Icons.touch_app_outlined,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
  'pulse_on_new_tracks': {
    'title': 'Show Ambient Display when a new music track is played',
    'subtitle': 'Show Ambient Display when a new music track is played',
    'icon': Icons.music_video_outlined,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
};

final Map<String, dynamic> sysbutton = {
  'volume_button_music_control': {
   'title': 'Volume button to skip tracks',
   'subtitle': 'Long press volume buttons to forward/backward track',
   'icon': Icons.music_note,
   'widget': WidgetType.SWITCH,
   'setting_type': SettingType.SYSTEM,
   'widget_data': {
     'default': false,
    },
    'version': '4.0.0',
  },
};
