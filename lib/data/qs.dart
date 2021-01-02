import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> qsData = {
  LocaleStrings.qs.tweaksTitle: qstweaks,
};

final Map<String, dynamic> qstweaks = {
  'qs_show_auto_brightness': {
    'title': LocaleStrings.qs.tweaksQsShowAutoBrightnessTitle,
    'subtitle': LocaleStrings.qs.tweaksQsShowAutoBrightnessDesc,
    'icon': Icons.brightness_6,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
  'qs_show_brightness_slider': {
    'title': LocaleStrings.qs.tweaksQsShowBrightnessSliderTitle,
    'subtitle': LocaleStrings.qs.tweaksQsShowBrightnessSliderDesc,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': LocaleStrings.qs.tweaksQsShowBrightnessSliderV0,
        '1': LocaleStrings.qs.tweaksQsShowBrightnessSliderV1,
        '2': LocaleStrings.qs.tweaksQsShowBrightnessSliderV2,
      },
      'default': '1',
    },
    'version': '4.0.0',
  },
  'qs_tile_title_visibility': {
    'title': LocaleStrings.qs.tweaksQsTileTitleVisibilityTitle,
    'subtitle': LocaleStrings.qs.tweaksQsTileTitleVisibilityDesc,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '4.0.0',
  },
  'qs_rows_portrait': {
    'title': LocaleStrings.qs.tweaksQsRowsPortraitTitle,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 2,
      'min': 1,
      'max': 5,
      'percentage': false,
    },
    'version': '4.0.0',
  },
  'qs_columns_portrait': {
    'title': LocaleStrings.qs.tweaksQsColumnsPortraitTitle,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 3,
      'min': 1,
      'max': 7,
      'percentage': false,
    },
    'version': '4.0.0',
  },
  'qs_rows_landscape': {
    'title': LocaleStrings.qs.tweaksQsRowsLandscapeTitle,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 1,
      'min': 1,
      'max': 5,
      'percentage': false,
    },
    'version': '4.0.0',
  },
  'qs_columns_landscape': {
    'title': LocaleStrings.qs.tweaksQsColumnsLandscapeTitle,
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 4,
      'min': 1,
      'max': 9,
      'percentage': false,
    },
    'version': '4.0.0',
  },
};
