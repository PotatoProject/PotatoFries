import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/locales/locale_strings.g.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:android_flutter_settings/android_flutter_settings.dart';

final Map<String, dynamic> themeData = {
  'Themes': theme,
};

final Map<String, dynamic> theme = {
  'system_accent': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'AccentPicker',
  },
  'system_icon_shape': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconShapePicker',
  },
  'system_icon_pack': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconPackPicker',
  },
  'systemui_plugin_volume': {
    'title': LocaleStrings.themes.themesSystemuiPluginVolumeTitle,
    'icon': Icons.music_note,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        'co.potatoproject.plugin.volume.aosp':
            LocaleStrings.themes.themesSystemuiPluginVolumeVAosp,
        'co.potatoproject.plugin.volume.compact':
            LocaleStrings.themes.themesSystemuiPluginVolumeVCompact,
        'co.potatoproject.plugin.volume.oreo':
            LocaleStrings.themes.themesSystemuiPluginVolumeVOreo,
        'co.potatoproject.plugin.volume.tiled':
            LocaleStrings.themes.themesSystemuiPluginVolumeVTiled,
      },
      'default': 'co.potatoproject.plugin.volume.aosp',
    },
    'version': '4.0.0',
    'cooldown': 1500,
  },
  'volume_panel_on_left': {
    'title': LocaleStrings.themes.themesVolumePanelOnLeftTitle,
    'icon': MdiIcons.arrowLeftRight,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': LocaleStrings.themes.themesVolumePanelOnLeftV0,
        '1': LocaleStrings.themes.themesVolumePanelOnLeftV1,
      },
      'default': '0',
    },
    'version': '4.0.0',
  },
};
