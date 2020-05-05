import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> buttons = {
  'System Buttons': sysbutton,
  'System Gestures': systemgesture,
  'Power Menu Configuration': powermenu,
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
    'version': '3.1.1',
  },
};

final Map<String, dynamic> powermenu = {
  'reboot_in_power_menu': {
    'title': 'Restart',
    'subtitle': 'Add restart in powermenu',
    'icon': MdiIcons.restart,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.1',
  },
  'advanced_reboot_in_power_menu': {
    'title': 'Advanced restart',
    'subtitle': 'Add advanced restart in powermenu',
    'icon': Icons.data_usage,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.1',
  },
  'screenshot_in_power_menu': {
    'title': 'Screenshot menu',
    'subtitle': 'Add screenshot in powermenu',
    'icon': MdiIcons.cellphoneScreenshot,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.1',
  },
  'screenrecord_in_power_menu': {
    'title': 'Screenrecord menu',
    'subtitle': 'Add screenrecord in powermenu',
    'icon': MdiIcons.video,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.1',
  },
  'lockdown_in_power_menu': {
    'title': 'Lockdown menu',
    'subtitle': 'Add lockdown in powermenu',
    'icon': Icons.lock_outline,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.1',
  },
  'lockscreen_enable_power_menu': {
    'title': 'Power menu on Lockscreen',
    'subtitle': 'Allow accessing power menu on secure lock screen',
    'icon': Icons.phonelink_lock,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.GLOBAL,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.1',
  },
};

final Map<String, dynamic> systemgesture = {
  'double_tap_sleep_gesture': {
    'title': 'Double tap Status bar to sleep',
    'subtitle': 'Tap twice on Status bar to put device in sleep',
    'icon': Icons.touch_app,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.1',
  },
  'three_finger_gesture': {
    'title': 'Three finger screenshot',
    'subtitle': 'Swipe down with three fingers to screenshot',
    'icon': Icons.camera,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.7',
  },
};
