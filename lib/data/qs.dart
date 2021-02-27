import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final PageData qs = PageData(
  key: 'qs',
  categories: [
    PageCategoryData(LocaleStrings.qs.tweaksTitle, qsTweaks),
  ],
);

final List<Preference> qsTweaks = [
  SettingPreference.withSwitch(
    setting: 'qs_tiles_bg_disco',
    title: LocaleStrings.qs.tweaksQsTilesBgDiscoTitle,
    description: LocaleStrings.qs.tweaksQsTilesBgDiscoDesc,
    icon: SmartIconData.iconData(MdiIcons.starPlus),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.4',
  ),
  SettingPreference.withSwitch(
    setting: 'qs_show_auto_brightness',
    title: LocaleStrings.qs.tweaksQsShowAutoBrightnessTitle,
    description: LocaleStrings.qs.tweaksQsShowAutoBrightnessDesc,
    icon: SmartIconData.iconData(Icons.brightness_6),
    type: SettingType.SECURE,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withDropdown(
    setting: 'qs_show_brightness_slider',
    title: LocaleStrings.qs.tweaksQsShowBrightnessSliderTitle,
    type: SettingType.SECURE,
    options: DropdownOptions(
      values: {
        '0': LocaleStrings.qs.tweaksQsShowBrightnessSliderV0,
        '1': LocaleStrings.qs.tweaksQsShowBrightnessSliderV1,
        '2': LocaleStrings.qs.tweaksQsShowBrightnessSliderV2,
      },
      defaultValue: '1',
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSwitch(
    setting: 'qs_tile_title_visibility',
    title: LocaleStrings.qs.tweaksQsTileTitleVisibilityTitle,
    description: LocaleStrings.qs.tweaksQsTileTitleVisibilityDesc,
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSlider(
    setting: 'qs_rows_portrait',
    title: LocaleStrings.qs.tweaksQsRowsPortraitTitle,
    type: SettingType.SYSTEM,
    options: SliderOptions(
      defaultValue: 2,
      min: 1,
      max: 5,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSlider(
    setting: 'qs_columns_portrait',
    title: LocaleStrings.qs.tweaksQsColumnsPortraitTitle,
    type: SettingType.SYSTEM,
    options: SliderOptions(
      defaultValue: 3,
      min: 1,
      max: 7,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSlider(
    setting: 'qs_rows_landscape',
    title: LocaleStrings.qs.tweaksQsRowsLandscapeTitle,
    type: SettingType.SYSTEM,
    options: SliderOptions(
      defaultValue: 1,
      min: 1,
      max: 5,
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withSlider(
    setting: 'qs_columns_landscape',
    title: LocaleStrings.qs.tweaksQsColumnsLandscapeTitle,
    type: SettingType.SYSTEM,
    options: SliderOptions(
      defaultValue: 4,
      min: 1,
      max: 9,
    ),
    minVersion: '4.0.0',
  ),
];
