import 'package:potato_fries/pages/audio_fx.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/pages/buttons.dart';
import 'package:potato_fries/pages/lock_screen.dart';
import 'package:potato_fries/pages/misc.dart';
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
  Buttons(),
  Themes(),
  StatusBar(),
  LockScreen(),
  Misc(),
  AudioFx(),
];

const List<String> shapesPackageLabels = [
  'Circle',
  'Teardrop',
  'Rounded Rectangle',
  'Squircle',
];

const List<String> iconPackPrefixes = [
  null,
  'com.android.theme.icon_pack.rounded',
  'com.android.theme.icon_pack.filled',
  'com.android.theme.icon_pack.circular',
];

const List<String> iconPackLabels = [
  'Default',
  'Rounded',
  'Filled',
  'Circular',
];

const Map<String, String> lockClocks = {
  'Default': 'com.android.keyguard.clock.DefaultClockController',
  'Bubble': 'com.android.keyguard.clock.BubbleClockController',
  'Analog': 'com.android.keyguard.clock.AnalogClockController',
  'Type': 'com.android.keyguard.clock.TypeClockController',
  'Bold': 'com.android.keyguard.clock.DefaultBoldClockController',
  'Sammy': 'com.android.keyguard.clock.SamsungClockController',
  'Sammy Bold': 'com.android.keyguard.clock.SamsungBoldClockController',
  'SFUNY': 'com.android.keyguard.clock.SfunyClockController',
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
