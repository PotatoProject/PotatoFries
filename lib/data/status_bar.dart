import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> statusBar = {
  'Display cutouts': displayCutouts,
  'StatusBar Icons': statusbaricons,
  'Network Traffic Monitor': netTraffic,
  'Battery': statusbarbattery,
  'Clock': statusbarclock,
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
    'title': 'Stock Statusbar in Hide',
    'subtitle': 'Use default (usually smaller) statusbar height in hide',
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

  'sysui_rounded_size': {
    'title': 'Rounded corner radius',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': -1,
      'min': 0,
      'max': 50,
      'percentage': false,
    },
    'version': '3.2.1',
  },
  'sysui_rounded_content_padding': {
    'title': 'Statusbar content padding',
    'widget': WidgetType.SLIDER,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': 10, // TODO: Average value, use @com.android.systemui/dimen:rounded_corner_content_padding in future
      'min': 0,
      'max': 20,
      'percentage': false,
    },
    'version': '3.2.1',
  },
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
    'icon': Icons.hd,
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
    'icon': MdiIcons.security,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.5',
  },
  'systemui_tuner_statusbar': {
    'title': 'System statusbar icons',
    'subtitle': 'Disable/Enable system icons from statusbar',
    'icon': Icons.settings_system_daydream,
    'widget': WidgetType.ACTIVITY,
    'class': 'com.android.systemui.tuner.StatusbarItemsActivity',
    'package': 'com.android.systemui',
  }
};

final Map<String, dynamic> netTraffic = {
  'network_traffic_state': {
    'title': 'Network traffic',
    'subtitle': 'Enable or disable network speed indicators',
    'icon': Icons.swap_vert,
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

final Map<String, dynamic> statusbarbattery = {
  'status_bar_battery_style': {
    'title': 'Battery Style',
    'icon': Icons.battery_full,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Portrait',
        '1': 'Circle',
        '2': 'Dotted Circle',
        '3': 'Solid Circle',
        '4': 'Text',
        '5': 'Hidden',
      },
      'default': '0',
    },
    'version': '3.1.7',
  },
  'status_bar_show_battery_percent': {
    'title': 'Battery Percentage',
    'icon': MdiIcons.percent,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'values': {
        '0': 'Hidden',
        '1': 'Inside the icon',
        '2': 'Next to the icon',
      },
      'default': '0',
    },
    'version': '3.1.7',
  },
  'qs_header_show_battery_percent':{
    'title': 'QS battery percentage',
    'subtitle': 'Show battery percentage in the QS header instead of estimate',
    'icon': Icons.battery_std,
    'widget':WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.8',
  },
};
final Map<String, dynamic> statusbarclock = {
  'status_bar_clock': {
    'title': 'Enable statusbar clock',
    'subtitle': 'Choose whether to show or hide the clock',
    'icon': Icons.access_time,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.7',
  },
  'smart_clock_enable': {
    'title': 'Smart Clock',
    'subtitle': 'Show statusbar clock periodically',
    'icon': MdiIcons.timerSandEmpty,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.SYSTEM,
    'widget_data': {
      'default': false,
    },
    'dependencies': [
      {
        'name': 'status_bar_clock',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '3.1.3',
  },
  'statusbar_clock_am_pm_style': {
    'title': 'AM/PM style',
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Hide AM/PM',
        '1': 'Small AM/PM',
        '2': 'Normal AM/PM',
      },
      'default': '0',
    },
    'dependencies': [
      {
        'name': 'status_bar_clock',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '3.1.7',
  },
  'statusbar_clock_date_display': {
    'title': 'Date visibility',
    'icon': Icons.visibility,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'No date',
        '1': 'Small date',
        '2': 'Normal date',
      },
      'default': '0',
    },
    'dependencies': [
      {
        'name': 'status_bar_clock',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '3.1.7',
  },
  'statusbar_clock_date_style': {
    'title': 'Date style',
    'icon': Icons.format_size,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Regular',
        '1': 'Lowercase',
        '2': 'Uppercase',
      },
      'default': '0',
    },
    'dependencies': [
      {
        'name': 'statusbar_clock_date_display',
        'setting_type': SettingType.SECURE,
        'values': ['1', '2'],
      },
      {
        'name': 'status_bar_clock',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '3.1.7',
  },
  'statusbar_clock_date_format': {
    'title': 'Date format',
    'icon': Icons.format_color_text,
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        'dd/MM/yy': 'dd/MM/yy',
        'MM/dd/yy': 'MM/dd/yy',
        'yyyy-MM-dd': 'yyyy-MM-dd',
        'yyyy-dd-MM': 'yyyy-dd-MM',
        'dd-MM-yyyy': 'dd-MM-yyyy',
        'MM-dd-yyyy': 'MM-dd-yyyy',
        'MMM dd': 'MMM dd',
        'MMM dd, yyyy': 'MMM dd, yyyy',
        'MMMM dd, yyyy': 'MMMM dd, yyyy',
        'EEE': 'EEE',
        'EEE dd': 'EEE dd',
        'EEE dd/MM': 'EEE dd/MM',
        'EEE MM/dd': 'EEE MM/dd',
        'EEE dd MMM': 'EEE dd MMM',
        'EEE MMM dd': 'EEE MMM dd',
        'EEE MMMM dd': 'EEE MMMM dd',
        'EEEE dd/MM': 'EEEE dd/MM',
      },
      'default': 'EEE',
    },
    'dependencies': [
      {
        'name': 'statusbar_clock_date_display',
        'setting_type': SettingType.SECURE,
        'values': ['1', '2'],
      },
      {
        'name': 'status_bar_clock',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '3.1.7',
  },
  'statusbar_clock_date_position': {
    'title': 'Date position',
    'widget': WidgetType.DROPDOWN,
    'setting_type': SettingType.SECURE,
    'widget_data': {
      'values': {
        '0': 'Left of clock',
        '1': 'Right of clock',
      },
      'default': '0',
    },
    'dependencies': [
      {
        'name': 'statusbar_clock_date_display',
        'setting_type': SettingType.SECURE,
        'values': ['1', '2'],
      },
      {
        'name': 'status_bar_clock',
        'setting_type': SettingType.SECURE,
        'value': true,
      },
    ],
    'version': '3.1.7',
  },
};
