import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final Map<String, List<Preference>> lockScreen = {
  LocaleStrings.lockscreen.clocksTitle: clocks,
  LocaleStrings.lockscreen.albumartTitle: albumArt,
};

final List<Preference> clocks = [
  CustomPreference(id: 'LockScreenClockPicker'),
];

final List<Preference> albumArt = [
  SettingPreference.withSwitch(
    title: LocaleStrings.lockscreen.albumartLockscreenMediaMetadataTitle,
    description: LocaleStrings.lockscreen.albumartLockscreenMediaMetadataDesc,
    icon: SmartIconData.iconData(Icons.image),
    setting: 'lockscreen_media_metadata',
    type: SettingType.SECURE,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSlider(
    title: LocaleStrings.lockscreen.albumartLockscreenMediaBlurTitle,
    setting: 'lockscreen_media_blur',
    type: SettingType.SYSTEM,
    options: SliderOptions(
      max: 25,
      defaultValue: 25,
    ),
    dependencies: [
      SettingDependency.boolean(
        name: 'lockscreen_media_metadata',
        type: SettingType.SECURE,
        value: true,
      ),
    ],
    minVersion: '4.0.0',
  ),
];
