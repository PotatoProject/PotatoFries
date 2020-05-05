import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> misc = {
  'Signature spoofing': spoofing,
};

final Map<String, dynamic> spoofing = {
  'allow_signature_fake': {
    'title': 'Toggle signature spoofing',
    'subtitle': 'Allow fake signatures',
    'icon': MdiIcons.incognito,
    'widget': WidgetType.SWITCH,
    'setting_type': SettingType.GLOBAL,
    'widget_data': {
      'default': true,
    },
    'version': '3.1.2',
  },
};
