import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:potato_fries/ui/custom_icons.dart';

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

const Map<String, IconData> pageInfo = {
  "Quick settings": CustomIcons.quick_settings,
  "Gestures": OMIcons.touchApp,
  "Themes": OMIcons.colorLens,
  "Statusbar": CustomIcons.status_bar,
  "Lockscreen": CustomIcons.screen_lock_portrait,
  "Miscellaneous": Icons.tune,
};

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
