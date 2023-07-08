import 'package:flutter/services.dart';

class PropertyKey {
  static const controlsChannel = MethodChannel("fries/properties/controls");

  final String name;

  const PropertyKey(this.name);

  Future<String?> read() async {
    String? value = await PropertyKey.controlsChannel
        .invokeMethod<String>("read", {"name": name});
    if (value!.trim().isEmpty) value = null;
    return value;
  }

  Future<void> write(String? value) async {
    await PropertyKey.controlsChannel.invokeMethod("write", {
      "name": name,
      "value": value ?? "",
    });
  }

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is PropertyKey) {
      return name == other.name;
    }

    return false;
  }

  @override
  String toString() => name;
}
