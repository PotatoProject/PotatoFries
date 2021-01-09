import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final Map<String, List<Preference>> system = {
  LocaleStrings.system.buttonsTitle: sysButton,
  LocaleStrings.system.gesturesTitle: systemGesture,
  LocaleStrings.system.networkTitle: network,
  LocaleStrings.system.packagemanagerTitle: packageManager,
  LocaleStrings.system.notificationsTitle: notifications,
};

final List<Preference> sysButton = [
  SettingPreference.withSwitch(
    setting: 'volume_button_music_control',
    title: LocaleStrings.system.buttonsVolumeButtonMusicControlTitle,
    description: LocaleStrings.system.buttonsVolumeButtonMusicControlDesc,
    icon: SmartIconData.iconData(Icons.music_note),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.0',
  ),
];

final List<Preference> systemGesture = [
  SettingPreference.withSwitch(
    setting: 'double_tap_sleep_lockscreen',
    title: LocaleStrings.system.gesturesDoubleTapSleepLockscreenTitle,
    description: LocaleStrings.system.gesturesDoubleTapSleepLockscreenDesc,
    icon: SmartIconData.iconData(Icons.touch_app_outlined),
    type: SettingType.SECURE,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSwitch(
    setting: 'pulse_on_new_tracks',
    title: LocaleStrings.system.gesturesPulseOnNewTracksTitle,
    description: LocaleStrings.system.gesturesPulseOnNewTracksDesc,
    icon: SmartIconData.iconData(Icons.music_video_outlined),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.0',
  ),
];

final List<Preference> network = [
  SettingPreference.withSwitch(
    setting: 'tethering_allow_vpn_upstreams',
    title: LocaleStrings.system.networkTetheringAllowVpnUpstreamsTitle,
    description: LocaleStrings.system.networkTetheringAllowVpnUpstreamsDesc,
    icon: SmartIconData.iconData(Icons.vpn_key),
    type: SettingType.SECURE,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.0',
  ),
];

final List<Preference> packageManager = [
  SettingPreference.withSwitch(
    setting: 'allow_signature_fake',
    title: LocaleStrings.system.packagemanagerAllowSignatureFakeTitle,
    description: LocaleStrings.system.packagemanagerAllowSignatureFakeDesc,
    icon: SmartIconData.iconData(MdiIcons.incognito),
    type: SettingType.SECURE,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.0',
  ),
];

final List<Preference> notifications = [
  SettingPreference.withSwitch(
    setting: 'less_boring_heads_up',
    title: LocaleStrings.system.notificationsLessBoringHeadsUpTitle,
    description: LocaleStrings.system.notificationsLessBoringHeadsUpDesc,
    icon: SmartIconData.iconData(MdiIcons.viewQuilt),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.0',
  ),
];
