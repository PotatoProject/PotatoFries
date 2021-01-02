import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> lockScreen = {
  LocaleStrings.lockscreen.clocksTitle: clocks,
  LocaleStrings.lockscreen.albumartTitle: albumArt,
};

final Map<String, dynamic> clocks = {
  'lock_screen_clock': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'LockScreenClockPicker',
  },
};

final Map<String, dynamic> albumArt = {
  'lockscreen_media_metadata': {
    'title': LocaleStrings.lockscreen.albumartLockscreenMediaMetadataTitle,
    'subtitle': LocaleStrings.lockscreen.albumartLockscreenMediaMetadataDesc,
    'icon': Icons.image,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
  'lockscreen_media_blur': {
    'title': LocaleStrings.lockscreen.albumartLockscreenMediaBlurTitle,
    'subtitle': LocaleStrings.lockscreen.albumartLockscreenMediaBlurDesc,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 25,
      'min': 0,
      'max': 25,
      'percentage': false,
    },
    'dependencies': [
      {
        'name': 'lockscreen_media_metadata',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '4.0.0',
  },
};
