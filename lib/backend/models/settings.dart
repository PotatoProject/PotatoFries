import 'package:flutter/services.dart';

class Setting<T> extends SettingKey<T> {
  final T defaultValue;

  const Setting(super.name, super.table, this.defaultValue);

  Setting.fromKey(SettingKey<T> key, this.defaultValue)
      : super(key.name, key.table);

  @override
  int get hashCode => Object.hash(super.hashCode, defaultValue);

  @override
  bool operator ==(Object other) {
    if (other is Setting) {
      return name == other.name &&
          table == other.table &&
          defaultValue == other.defaultValue;
    }

    return false;
  }
}

class SettingKey<T> {
  static const controlsChannel = MethodChannel("fries/settings/controls");

  final String name;
  final SettingTable table;

  const SettingKey(this.name, this.table);

  Future<void> write(T? value) {
    final String valueStr = switch (value) {
      final bool boolValue => boolValue ? "1" : "0",
      _ => value.toString(),
    };

    return SettingKey.controlsChannel.invokeMethod("write", {
      "uri": uri.toString(),
      "value": valueStr,
    });
  }

  @override
  int get hashCode => Object.hash(name, table);

  @override
  bool operator ==(Object other) {
    if (other is SettingKey) {
      return name == other.name && table == other.table;
    }

    return false;
  }

  Uri get uri => composeUri(name, table);

  @override
  String toString() => uri.toString();

  static Uri composeUri(String name, SettingTable table) {
    return Uri(
      scheme: "content",
      host: "settings",
      pathSegments: [table.name, name],
    );
  }
}

enum SettingTable {
  global,
  secure,
  system,
}

enum SettingType {
  string,
  integer,
  float,
  boolean,
}
