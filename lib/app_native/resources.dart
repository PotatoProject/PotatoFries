import 'package:flutter/services.dart';

class Resources {
  static const MethodChannel _channel = const MethodChannel('fries/resources');

  static Future<int> getColor(String pkg, String resName) async =>
      await _channel.invokeMethod('getColor', {
        'pkg': pkg,
        'resName': resName,
      });

  static Future<int> getAccentDark() async =>
      await getColor('android', 'accent_device_default_light');

  static Future<int> getAccentLight() async =>
      await getColor('android', 'accent_device_default_dark');
}
