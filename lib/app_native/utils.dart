import 'package:flutter/services.dart';

class Utils {
  static const MethodChannel _channel = const MethodChannel('fries/utils');

  static Future<void> startActivity({String pkg, String cls}) async =>
      await _channel.invokeMethod('startActivity', {'pkg': pkg, 'cls': cls});
}
