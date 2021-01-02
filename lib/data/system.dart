import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> system = {
  LocaleStrings.system.buttonsTitle: sysButton,
  LocaleStrings.system.gesturesTitle: systemGesture,
  LocaleStrings.system.networkTitle: network,
  LocaleStrings.system.packagemanagerTitle: packageManager,
  LocaleStrings.system.notificationsTitle: notifications,
};

final Map<String, dynamic> sysButton = {
  'volume_button_music_control': {
    'title': LocaleStrings.system.buttonsVolumeButtonMusicControlTitle,
    'subtitle': LocaleStrings.system.buttonsVolumeButtonMusicControlDesc,
    'icon': Icons.music_note,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
};

final Map<String, dynamic> systemGesture = {
  'double_tap_sleep_lockscreen': {
    'title': LocaleStrings.system.gesturesDoubleTapSleepLockscreenTitle,
    'subtitle': LocaleStrings.system.gesturesDoubleTapSleepLockscreenDesc,
    'icon': Icons.touch_app_outlined,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
  'pulse_on_new_tracks': {
    'title': LocaleStrings.system.gesturesPulseOnNewTracksTitle,
    'subtitle': LocaleStrings.system.gesturesPulseOnNewTracksDesc,
    'icon': Icons.music_video_outlined,
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
    'title': LocaleStrings.system.networkTetheringAllowVpnUpstreamsTitle,
    'subtitle': LocaleStrings.system.networkTetheringAllowVpnUpstreamsDesc,
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
    'title': LocaleStrings.system.packagemanagerAllowSignatureFakeTitle,
    'subtitle': LocaleStrings.system.packagemanagerAllowSignatureFakeDesc,
    'icon': MdiIcons.incognito,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
};

final Map<String, dynamic> notifications = {
  'less_boring_heads_up': {
    'title': LocaleStrings.system.notificationsLessBoringHeadsUpTitle,
    'subtitle': LocaleStrings.system.notificationsLessBoringHeadsUpDesc,
    'icon': MdiIcons.viewQuilt,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '4.0.0',
  },
};
