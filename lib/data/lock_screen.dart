import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final PageData lockScreen = PageData(
  key: 'lock_screen',
  categories: [
    // PageCategoryData(LocaleStrings.lockscreen.clocksTitle, clocks),
  ],
);

final List<Preference> clocks = [
  // CustomPreference(id: 'LockScreenClockPicker'),
];