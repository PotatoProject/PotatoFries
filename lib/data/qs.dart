import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';

final PageData qs = PageData(
  key: 'qs',
  categories: [
    PageCategoryData(LocaleStrings.qs.colorsTitle, qsColors),
    PageCategoryData(LocaleStrings.qs.tweaksTitle, qsTweaks),
  ],
);

final List<Preference> qsColors = [
  SettingPreference.withSwitch(
    setting: 'qs_panel_bg_use_fw',
    title: LocaleStrings.qs.colorsQsPanelBgUseFwTitle,
    description: LocaleStrings.qs.colorsQsPanelBgUseFwDesc,
    icon: SmartIconData.iconData(MdiIcons.android),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: true,
    ),
    minVersion: '4.1.2',
    dependencies: [
      SettingDependency.boolean(
        name: 'qs_tiles_bg_disco',
        type: SettingType.SYSTEM,
        value: false,
      ),
    ],
  ),
  SettingPreference.withSwitch(
    setting: 'qs_tiles_bg_disco',
    title: LocaleStrings.qs.colorsQsPanelBgDiscoTitle,
    description: LocaleStrings.qs.colorsQsPanelBgDiscoDesc,
    icon: SmartIconData.iconData(MdiIcons.starPlus),
    type: SettingType.SYSTEM,
    options: SwitchOptions(
      defaultValue: false,
    ),
    minVersion: '4.0.4',
    dependencies: [
      SettingDependency.boolean(
        name: 'qs_panel_bg_use_fw',
        type: SettingType.SYSTEM,
        value: true,
      ),
    ],
  ),
  SettingPreference.withColor(
    setting: 'qs_panel_bg_color',
    title: LocaleStrings.qs.colorsQsPanelBgColorTitle,
    description: LocaleStrings.qs.colorsQsPanelBgColorDesc,
    type: SettingType.SYSTEM,
    options: ColorOptions(
      minLightness: 0.0,
      maxLightness: 0.6,
      supportsNormalization: true,
    ),
    minVersion: '4.1.2',
    dependencies: [
      SettingDependency.boolean(
        name: 'qs_panel_bg_use_fw',
        type: SettingType.SYSTEM,
        value: false,
      ),
      SettingDependency.boolean(
        name: 'sysui_colors_active',
        type: SettingType.SYSTEM,
        value: false,
      ),
    ],
  ),
  SettingPreference.withSlider(
    setting: 'qs_panel_bg_alpha',
    title: LocaleStrings.qs.colorsQsPanelBgAlphaTitle,
    type: SettingType.SYSTEM,
    options: SliderOptions(
      min: 100,
      max: 255,
      defaultValue: 255,
    ),
    minVersion: '4.1.2',
    dependencies: [
      SettingDependency.boolean(
        name: 'qs_panel_bg_use_fw',
        type: SettingType.SYSTEM,
        value: false,
      ),
    ],
  ),
];

final List<Preference> qsTweaks = [
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
