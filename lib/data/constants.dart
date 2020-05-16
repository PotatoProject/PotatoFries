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
];

const List<String> shapesPackages = [
  null,
  'com.android.theme.icon.teardrop',
  'com.android.theme.icon.roundedrect',
  'com.android.theme.icon.squircle',
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
};