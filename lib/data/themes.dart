import 'package:potato_fries/widgets/directory.dart';

final Map<String, dynamic> themeData = {
  'Accent': themeAccent,
};

final Map<String, dynamic> themeAccent = {
  'system_accent': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'AccentPicker',
  },
  'system_icon_shape': {
    'widget': WidgetType.CUSTOM,
    'setting_type': 'IconShapePicker',
  },
};
