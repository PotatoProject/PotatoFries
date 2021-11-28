import 'package:flutter/material.dart';
import 'package:potato_fries/backend/data.dart';
import 'package:potato_fries/backend/models/properties.dart';
import 'package:provider/provider.dart';

class PropertyRegister {
  static PropertyRegister of(BuildContext context) {
    return Provider.of<PropertyRegister>(context, listen: false);
  }

  final Map<PropertyKey, String?> _register = {};

  Future<void> register(PropertyKey key) async {
    if (!key.name.startsWith("ro.")) {
      throw Exception("Only read-only properties are supported: ${key.name}");
    }

    _register[key] = await key.read();
  }

  String? get(PropertyKey key) {
    return _register[key];
  }

  // Some getters for internal properties
  String get vernum => get(Properties.ro_potato_vernum)!;
  String get device => get(Properties.ro_potato_device)!;
  String get model => get(Properties.ro_product_model)!;
  String get version => get(Properties.ro_potato_version)!;
  String get dish => get(Properties.ro_potato_dish)!;
}
