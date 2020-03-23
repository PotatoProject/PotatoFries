import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'StatusBar Icons': statusbaricons,
  'Clock': statusbarclock,
  'Network Traffic Monitor': netTraffic,
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
'use_old_mobiletype': {
'title': 'Old mobile data icons',
'subtitle': 'Merge signal and type icons',
'widget': WidgetType.SWITCH,
'setting_type': SettingType.SYSTEM,
'widget_data': {
'default': false,
    },
  },
};

final Map<String, dynamic> statusbarclock = {
  'smart_clock_enable': {
    'title': 'Smart Clock' ,
    'subtitle': 'Show statusbar clock periodically' ,
    'icon': Icons.fiber_smart_record ,
    'widget': WidgetType.SWITCH ,
    'setting_type': SettingType.SYSTEM ,
    'widget_data': {
      'default': false ,
    } ,
    'version': '3.1.3' ,
  } ,
  'status_bar_clock': {
    'title': 'Hide or show clock on statusbar' ,
    'icon': Icons.crop_portrait ,
    'widget': WidgetType.DROPDOWN ,
    'setting_type': SettingType.SECURE ,
    'widget_data': {
      'values': {
        '0': 'Hide' ,
        '1': 'Show' ,
      }
    } ,
    'dependencies': [
      {
        'name': 'smart_clock_enable' ,
        'setting_type': SettingType.SYSTEM ,
        'value': false ,
      } ,
    ] ,
    'version': '3.1.3' ,
  } ,
  'statusbar_clock_am_pm_style': {
    'title': 'AM/PM style' ,
    'icon': Icons.crop_portrait ,
    'widget': WidgetType.DROPDOWN ,
    'setting_type': SettingType.SECURE ,
    'widget_data': {
      'values': {
        '0': 'Hide AM/PM' ,
        '1': 'Small AM/PM' ,
        '2': 'Normal AM/PM' ,
      }
    } ,
    'version': '3.1.3' ,
  } ,
  'statusbar_clock_date_display': {
    'title': 'Date size' ,
    'icon': Icons.crop_portrait ,
    'widget': WidgetType.DROPDOWN ,
    'setting_type': SettingType.SECURE ,
    'widget_data': {
      'values': {
        '0': 'No date' ,
        '1': 'Small date' ,
        '2': 'Normal date' ,
      }
    } ,
    'version': '3.1.3' ,
  } ,
  'statusbar_clock_date_style': {
    'title': 'Date style' ,
    'icon': Icons.crop_portrait ,
    'widget': WidgetType.DROPDOWN ,
    'setting_type': SettingType.SECURE ,
    'widget_data': {
      'values': {
        '0': 'Regular' ,
        '1': 'Lowercase' ,
        '2': 'Uppercase' ,
      }
    } ,
    'version': '3.1.3' ,
  } ,
  'statusbar_clock_date_position': {
    'title': 'Date position' ,
    'icon': Icons.crop_portrait ,
    'widget': WidgetType.DROPDOWN ,
    'setting_type': SettingType.SECURE ,
    'widget_data': {
      'values': {
        '0': 'Left of clock' ,
        '1': 'Right of clock' ,
      }
    } ,
    'version': '3.1.3' ,
  } ,
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
  },
  'network_traffic_hidearrow': {
    'title': 'Hide arrows',
    'subtitle': 'Hide the network traffic indicator arrows',
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
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
  },
};