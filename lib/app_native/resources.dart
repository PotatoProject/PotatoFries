import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/services.dart';

class Resources {
  static const MethodChannel _channel = const MethodChannel('fries/resources');

  static Future<int> getColor(String pkg, String resName) async =>
      await _channel.invokeMethod('getColor', {
        'pkg': pkg,
        'resName': resName,
      });

  static Future<Map<String, String>> getShapes() async =>
      await _channel.invokeMapMethod<String, String>("getShapes");

  static Future<Map<String, String>> getShapeLabels() async =>
      await _channel.invokeMapMethod<String, String>("getShapeLabels");

  static Future<Map<String, Map<dynamic, dynamic>>>
      getIconsWithPreviews() async =>
          await _channel.invokeMapMethod<String, Map<dynamic, dynamic>>(
              "getIconsWithPreviews");

  static Future<Map<String, String>> getIconsWithLabels() async =>
      await _channel.invokeMapMethod<String, String>("getIconsWithLabels");

  static Future<int> getAccentSetting(String setting) async {
    var colorString = await AndroidFlutterSettings.getString(
      setting,
      SettingType.SECURE,
    );
    if (colorString == null || colorString.isEmpty) {
      return null;
    }
    return int.parse(
      colorString,
      radix: 16,
    );
  }

  static Future<int> getAccentDark() async =>
      await getAccentSetting('accent_dark') ??
      getColor('android', 'accent_device_default_dark');

  static Future<int> getAccentLight() async =>
      await getAccentSetting('accent_light') ??
      getColor('android', 'accent_device_default_light');
}
