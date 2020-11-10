import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:android_flutter_settings/android_flutter_settings.dart';

final Map<String, dynamic> themeData = {
  'Themes': theme,
};

final Map<String, dynamic> theme = {
  'system_icon_shape': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconShapePicker',
  },
  'system_icon_pack': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconPackPicker',
  },
};
