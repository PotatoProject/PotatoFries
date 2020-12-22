import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> system = {
  'System Buttons': sysButton,
  'System Gestures': systemGesture,
  'Network': network,
  'Package Manager': packageManager,
};

final Map<String, dynamic> systemGesture = {
  'double_tap_sleep_lockscreen': {
    'title': 'Double tap to sleep on lockscreen',
    'subtitle': 'Turn off screen by double tapping empty space on lockscreen',
    'icon': Icons.touch_app_outlined,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
  'pulse_on_new_tracks': {
    'title': 'Ambient music tracks',
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

final Map<String, dynamic> sysButton = {
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

final Map<String, dynamic> network = {
  'tethering_allow_vpn_upstreams': {
    'title': 'Allow clients to use VPNs',
    'subtitle':
        'Permit hotspot/tethering clients to use this device\'s VPN connection',
    'icon': Icons.vpn_key,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
};

final Map<String, dynamic> packageManager = {
  'allow_signature_fake': {
    'title': 'Toggle signature spoofing',
    'subtitle': 'Allow fake signatures',
    'icon': MdiIcons.incognito,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.GLOBAL,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.2',
  },
};