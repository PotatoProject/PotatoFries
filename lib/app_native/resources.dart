import 'dart:typed_data';

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

  static Future<int> getAccentDark() async => int.parse(
        await AndroidFlutterSettings.getString(
          "accent_dark",
          SettingType.SECURE,
        ),
        radix: 16,
      );

  static Future<int> getAccentLight() async => int.parse(
        await AndroidFlutterSettings.getString(
          "accent_light",
          SettingType.SECURE,
        ),
        radix: 16,
      );
}
