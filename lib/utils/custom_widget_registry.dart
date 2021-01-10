import 'package:flutter/cupertino.dart';

class CustomWidgetRegistry {
  static Map<String, Widget> _registry = <String, Widget>{};

  static void register(Widget c) => _registry[c.runtimeType.toString()] = c;

  static Widget fromString(String type) => _registry[type];
}
