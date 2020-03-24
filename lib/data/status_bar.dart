import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'StatusBar Icons': statusbaricons,
  'Network Traffic Monitor': netTraffic,
  'Display cutouts': displayCutouts,
};

final Map<String, dynamic> statusbaricons = {
  'smart_clock_enable': {
    'title': 'Smart Clock',
    'subtitle': 'Show statusbar clock periodically',
    'icon': Icons.fiber_smart_record,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.3',
  },
  'status_bar_logo': {
    'title': 'POSP swag',
    'subtitle': 'Show off POSP logo on statusbar',
    'icon': Icons.crop_portrait,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.1',
  },
  'show_fourg_icon': {
    'title': '4G icon',
    'subtitle': 'Display 4G icon in status bar instead LTE',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.1',
  },
  'volte_icon': {
    'title': 'VoLTE icon',
    'subtitle': 'Display HD icon in status bar for VoLTE',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.1',
  },
  'use_old_mobiletype': {
    'title': 'Old mobile data icons',
    'subtitle': 'Merge signal and type icons',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.5',
  },
  'statusbar_privacy_indicators': {
    'title': 'Statusbar privacy indicators',
    'subtitle': 'Show permission hub icons on statusbar',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.5',
  },
};

final Map<String, dynamic> netTraffic = {
  'network_traffic_state': {
    'title': 'Network traffic',
    'subtitle': 'Enable or disable network speed indicators',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'version': '3.1.5',
  },
  'network_traffic_hidearrow': {
    'title': 'Hide arrows',
    'subtitle': 'Hide the network traffic indicator arrows',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'dependencies': [
      {
        'name': 'network_traffic_state',
        'setting_type': SettingType.SYSTEM,
        'value': true,
      },
    ],
    'version': '3.1.5',
  },
  'network_traffic_autohide_threshold': {
    'title': 'Net activity autohide threshold (KB/s)',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': 0,
      'min': 0,
      'max': 10,
      'percentage': true,
    },
    'dependencies': [
      {
        'name': 'network_traffic_state',
        'setting_type': SettingType.SYSTEM,
        'value': true,
      },
    ],
    'version': '3.1.5',
  },
};

final Map<String, dynamic> displayCutouts = {
  'display_cutout_mode': {
    'title': 'Cutout mode',
    'icon': Icons.aspect_ratio,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Normal',
        '1': 'Immerse',
        '2': 'Hide',
      },
      'default': '0',
    },
    'compat': {
      'prop': 'ro.potato.has_cutout',
    },
    'version': '3.1.5',
  },
  'stock_statusbar_in_hide': {
    'title': 'Stock Statusbar in hide',
    'subtitle': 'Use default (usually larger) statusbar height in hide',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'dependencies': [
      {
        'name': 'display_cutout_mode',
        'setting_type': SettingType.SYSTEM,
        'value': '2',
      },
    ],
    'version': '3.1.5',
  },
};
