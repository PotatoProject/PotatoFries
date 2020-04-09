import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'StatusBar Icons': statusbaricons,
  'Network Traffic Monitor': netTraffic,
  'Display cutouts': displayCutouts,
  'Battery': statusbarbattery,
  'Clock': statusbarclock,
};

final Map<String, dynamic> statusbaricons = {
  'status_bar_logo': {
    'title': 'POSP swag',
    'subtitle': 'Show off POSP logo on statusbar',
    'icon': Icons.android,
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
    'icon': Icons.signal_cellular_4_bar,
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
    'icon': Icons.signal_cellular_null,
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
    'icon': Icons.network_locked,
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
    'icon': Icons.phonelink_lock,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.5',
  },
  'systemui_tuner_statusbar': {
    'title': 'System statusbar icons' ,
    'subtitle': 'Disable/Enable system icons from statusbar',
    'icon': Icons.settings_system_daydream,
    'widget': WidgetType.ACTIVITY ,
    'class': 'com.android.systemui.tuner.StatusbarItemsActivity' ,
    'package': 'com.android.systemui' ,
  }
};

final Map<String, dynamic> netTraffic = {
  'network_traffic_state': {
    'title': 'Network traffic',
    'subtitle': 'Enable or disable network speed indicators',
    'icon': Icons.compare_arrows,
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
    'icon': Icons.arrow_drop_down,
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
    'icon': Icons.check_box_outline_blank,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'compat': {
      'prop': 'ro.potato.has_cutout',
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

final Map<String, dynamic> statusbarbattery = {
  'status_bar_battery_style': {
    'title': 'Battery Style',
    'icon': Icons.battery_unknown,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Portrait' ,
        '1': 'Circle' ,
        '2': 'Dotted Circle' ,
        '3': 'Solid Circle' ,
        '4': 'Hidden' ,
      },
      'default': '0',
    },
  },
  'status_bar_show_battery_percent': {
    'title': 'Battery Percentage',
    'icon': Icons.battery_full,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Disabled' ,
        '1': 'Enabled' ,
        '2': 'Enabled while charging' ,
      },
      'default': '0',
    },
  },
};
final Map<String, dynamic> statusbarclock = {
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
  'status_bar_clock': {
    'title': 'Hide or show clock on statusbar',
    'icon': Icons.access_time,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Hide' ,
        '1': 'Show' ,
      },
      'default': '1'
    },
    'dependencies': [
      {
        'name': 'smart_clock_enable',
        'setting_type': SettingType.SYSTEM,
        'value': false,
      },
    ],
    'version': '3.1.5',
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
      },
      'default': '0',
    },
    'version': '3.1.5',
  },
  'statusbar_clock_date_display': {
    'title': 'Date size',
    'icon': Icons.format_size,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'No date' ,
        '1': 'Small date' ,
        '2': 'Normal date' ,
      },
      'default': '0',
    },
    'version': '3.1.5',
  },
  'statusbar_clock_date_style': {
    'title': 'Date style',
    'icon': Icons.format_size,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Regular' ,
        '1': 'Lowercase' ,
        '2': 'Uppercase' ,
      },
      'default': '0',
    },
    'version': '3.1.5',
  },
  'statusbar_clock_date_position': {
    'title': 'Date position',
    'icon': Icons.insert_chart,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Left of clock' ,
        '1': 'Right of clock' ,
      },
      'default': '0',
    },
    'version': '3.1.5',
  },
};
