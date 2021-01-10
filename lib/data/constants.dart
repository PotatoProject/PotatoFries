import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/pages/audio_fx.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/pages/system.dart';
import 'package:potato_fries/pages/lock_screen.dart';
import 'package:potato_fries/pages/qs.dart';
import 'package:potato_fries/pages/status_bar.dart';
import 'package:potato_fries/pages/themes.dart';

const String OVERLAY_CATEGORY_COLOR =
    'android.theme.customization.accent_color';

const String OVERLAY_CATEGORY_FONT = 'android.theme.customization.font';

const String OVERLAY_CATEGORY_SHAPE =
    'android.theme.customization.adaptive_icon_shape';

const String OVERLAY_CATEGORY_ICON_ANDROID =
    'android.theme.customization.icon_pack.android';

const String OVERLAY_CATEGORY_ICON_SYSUI =
    'android.theme.customization.icon_pack.systemui';

const String OVERLAY_CATEGORY_ICON_SETTINGS =
    'android.theme.customization.icon_pack.settings';

const String OVERLAY_CATEGORY_ICON_LAUNCHER =
    'android.theme.customization.icon_pack.launcher';

const String OVERLAY_CATEGORY_ICON_THEME_PICKER =
    'android.theme.customization.icon_pack.themepicker';

List<BasePage> pages = [
  QuickSettings(),
  System(),
  Themes(),
  StatusBar(),
  LockScreen(),
  AudioFx(),
];

final Map<String, String> lockClocks = {
  LocaleStrings.lockscreen.clocksLockScreenClockVDefault:
      'com.android.keyguard.clock.DefaultClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVBubble:
      'com.android.keyguard.clock.BubbleClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVAnalog:
      'com.android.keyguard.clock.AnalogClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVType:
      'com.android.keyguard.clock.TypeClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVBold:
      'com.android.keyguard.clock.DefaultBoldClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVSammy:
      'com.android.keyguard.clock.SamsungClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVSammybold:
      'com.android.keyguard.clock.SamsungBoldClockController',
  LocaleStrings.lockscreen.clocksLockScreenClockVSfuny:
      'com.android.keyguard.clock.SfunyClockController',
};

const typeHeader = "It's";

const List<String> typeHour = [
  "Twelve",
  "One",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine",
  "Ten",
  "Eleven",
];
const List<String> typeMinute = [
  "O' Clock",
  "Oh One",
  "Oh Two",
  "Oh Three",
  "Oh Four",
  "Oh Five",
  "Oh Six",
  "Oh Seven",
  "Oh Eight",
  "Oh Nine",
  "Ten",
  "Eleven",
  "Twelve",
  "Thirteen",
  "Fourteen",
  "Fifteen",
  "Sixteen",
  "Seventeen",
  "Eighteen",
  "Nineteen",
  "Twenty",
  "Twenty\nOne",
  "Twenty\nTwo",
  "Twenty\nThree",
  "Twenty\nFour",
  "Twenty\nFive",
  "Twenty\nSix",
  "Twenty\nSeven",
  "Twenty\nEight",
  "Twenty\nNine",
  "Thirty",
  "Thirty\nOne",
  "Thirty\nTwo",
  "Thirty\nThree",
  "Thirty\nFour",
  "Thirty\nFive",
  "Thirty\nSix",
  "Thirty\nSeven",
  "Thirty\nEight",
  "Thirty\nNine",
  "Forty",
  "Forty\nOne",
  "Forty\nTwo",
  "Forty\nThree",
  "Forty\nFour",
  "Forty\nFive",
  "Forty\nSix",
  "Forty\nSeven",
  "Forty\nEight",
  "Forty\nNine",
  "Fifty",
  "Fifty\nOne",
  "Fifty\nTwo",
  "Fifty\nThree",
  "Fifty\nFour",
  "Fifty\nFive",
  "Fifty\nSix",
  "Fifty\nSeven",
  "Fifty\nEight",
  "Fifty\nNine",
];

const BuildVersion threeDotOneDotSeven = const BuildVersion(3, 1, 7);
