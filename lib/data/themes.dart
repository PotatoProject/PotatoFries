import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:android_flutter_settings/android_flutter_settings.dart';

final PageData themes = PageData(
  key: 'themes',
  categories: [
    PageCategoryData(LocaleStrings.themes.themesTitle, theme),
  ],
);

final List<Preference> theme = [
  CustomPreference(id: 'AccentPicker'),
  SettingPreference.withSwitch(
    setting: 'sysui_colors_active',
    title: LocaleStrings.themes.themesSysuiColorsActiveTitle,
    description: LocaleStrings.themes.themesSysuiColorsActiveDesc,
    icon: SmartIconData.iconData(MdiIcons.selectColor),
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
  CustomPreference(id: 'IconShapePicker'),
  CustomPreference(id: 'IconPackPicker'),
  SettingPreference.withDropdown(
    setting: 'systemui_plugin_volume',
    title: LocaleStrings.themes.themesSystemuiPluginVolumeTitle,
    icon: SmartIconData.iconData(Icons.music_note),
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        'co.potatoproject.plugin.volume.aosp':
            LocaleStrings.themes.themesSystemuiPluginVolumeVAosp,
        'co.potatoproject.plugin.volume.compact':
            LocaleStrings.themes.themesSystemuiPluginVolumeVCompact,
        'co.potatoproject.plugin.volume.oreo':
            LocaleStrings.themes.themesSystemuiPluginVolumeVOreo,
        'co.potatoproject.plugin.volume.tiled':
            LocaleStrings.themes.themesSystemuiPluginVolumeVTiled,
      },
      defaultValue: 'co.potatoproject.plugin.volume.aosp',
    ),
    minVersion: '4.0.0',
  ),
  SettingPreference.withDropdown(
    setting: 'volume_panel_on_left',
    title: LocaleStrings.themes.themesVolumePanelOnLeftTitle,
    icon: SmartIconData.iconData(MdiIcons.arrowLeftRight),
    type: SettingType.SYSTEM,
    options: DropdownOptions(
      values: {
        '0': LocaleStrings.themes.themesVolumePanelOnLeftV0,
        '1': LocaleStrings.themes.themesVolumePanelOnLeftV1,
      },
      defaultValue: '0',
    ),
    minVersion: '4.0.0',
  ),
];
