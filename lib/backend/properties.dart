import 'package:flutter/material.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:provider/provider.dart';

class PropertyRegister {
  static PropertyRegister of(BuildContext context) {
    return Provider.of<PropertyRegister>(context, listen: false);
  }

  final Map<PropertyKey, String?> _register = {};

  Future<void> register(PropertyKey key) async {
    assert(
      key.name.startsWith("ro."),
      "Only read-only properties are supported",
    );
    _register[key] = await key.read();
  }

  String? get(PropertyKey key) {
    return _register[key];
  }
}
