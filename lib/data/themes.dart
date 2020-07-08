import 'package:potato_fries/widgets/directory.dart';

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
  'color_bucket_overlay': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'ThemeSelector',
  },
  'systemui_plugin_volume': {
    'title': 'Volume panel',
    'icon': Icons.music_note,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        'co.potatoproject.plugin.volume.aosp': 'AOSP',
        'co.potatoproject.plugin.volume.compact': 'Compact',
        'co.potatoproject.plugin.volume.oreo': 'Oreo',
        'co.potatoproject.plugin.volume.tiled': 'Tiled',
      },
      'default': 'co.potatoproject.plugin.volume.aosp',
    },
    'version': '3.2.0',
    'cooldown': 1500,
  },
};
