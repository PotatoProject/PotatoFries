import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'StatusBar Icons': statusbaricons,
  'Clock': statusbarclock,
};

final Map<String, dynamic> statusbaricons = {
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
};

final Map<String, dynamic> statusbarclock = {
'status_bar_clock': {
'title': 'Hide or show clock on statusbar',
'icon': Icons.crop_portrait,
'widget': WidgetType.DROPDOWN,
'setting_type': SettingType.SECURE,
'widget_data': {
'values': {
  '0': 'Hide' ,
  '1': 'Show' ,
      }
    },
  'version': '3.1.1',
  },
  'statusbar_clock_am_pm_style': {
    'title': 'AM/PM style',
    'icon': Icons.crop_portrait,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Hide AM/PM' ,
        '1': 'Small AM/PM' ,
        '2': 'Normal AM/PM' ,
      }
    },
    'version': '3.1.1',
  },
};
