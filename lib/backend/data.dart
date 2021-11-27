// ignore_for_file: constant_identifier_names

import 'package:potato_fries/backend/models/properties.dart';
import 'package:potato_fries/backend/models/settings.dart';

class Settings {
  static const Setting<bool> airplane_mode_on =
      Setting<bool>("airplane_mode_on", SettingTable.global, false);

  static const Setting<int> screen_brightness =
      Setting<int>("screen_brightness", SettingTable.system, 0);

  static const Setting<int> logger_buffer_size =
      Setting<int>("logger_buffer_size", SettingTable.secure, 0);

  static const List<Setting> all = [
    airplane_mode_on,
    screen_brightness,
    logger_buffer_size,
  ];
}

class Properties {
  static const PropertyKey ro_potato_has_cutout =
      PropertyKey("ro.potato.has_cutout");
}
