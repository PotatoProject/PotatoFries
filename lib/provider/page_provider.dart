import 'dart:convert';

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/data/models.dart';

class PageProvider extends ChangeNotifier {
  static final SettingKey lsClockKey = SettingKey<String>(
    "lock_screen_custom_clock_face",
    SettingType.SECURE,
  );
  Set<String> warmedUpPages = {};

  PageProvider() {
    loadData();
  }

  Map<BaseKey, dynamic> _data = {};

  set data(Map<BaseKey, Notifier> value) {
    _data = value;
    notifyListeners();
  }

  Map<BaseKey, dynamic> get data => _data;

  dynamic getValue(BaseKey key) => _data[key];

  void setValue(BaseKey key, dynamic value) async {
    final item = _data[key];

    if (item != null) {
      if (key is SettingKey) {
        if (value != null) {
          switch (key.valueType) {
            case SettingValueType.BOOLEAN:
              await AndroidFlutterSettings.putBool(
                key,
                value,
              );
              break;
            case SettingValueType.INT:
              await AndroidFlutterSettings.putInt(
                key,
                value.toInt(),
              );
              break;
            case SettingValueType.STRING:
              await AndroidFlutterSettings.putString(
                key,
                value,
              );
              break;
          }
        }
      } else if (item is PropKey) {
        if (value != null) {
          await AndroidFlutterSettings.setProp(
            key,
            value,
          );
        }
      }
    }

    _data[key] = value;
    notifyListeners();
  }

  Future<void> loadLSClockData() async {
    String valueStr = await AndroidFlutterSettings.getString(lsClockKey);
    Map value = valueStr == null ? null : json.decode(valueStr);
    this.setValue(
      lsClockKey,
      getLSClockKey(value == null
          ? "com.android.keyguard.clock.DefaultClockController"
          : value['clock']),
    );
  }

  String getLSClockData() => getValue(lsClockKey);

  void setLSClockData(String data) async {
    Map<String, String> value = {
      'clock': lockClocks[data] ?? lockClocks[lockClocks.keys.toList()[0]],
    };
    await AndroidFlutterSettings.putString(
      lsClockKey,
      json.encode(value),
    );
    setValue(
      lsClockKey,
      getLSClockKey(value['clock']),
    );
  }

  String getLSClockValue(String key) =>
      lockClocks[key] ?? lockClocks[lockClocks.keys.first];

  String getLSClockKey(String value) =>
      lockClocks.keys.firstWhere((key) => lockClocks[key] == value,
          orElse: () => lockClocks.keys.first);

  void loadData() async {
    await loadLSClockData();
    notifyListeners();
  }

  void warmupPage(String pageId) async {
    dynamic getNative(SettingKey key) async {
      switch (key.valueType) {
        case SettingValueType.BOOLEAN:
          return await AndroidFlutterSettings.getBool(key);
        case SettingValueType.INT:
          return await AndroidFlutterSettings.getInt(key);
        case SettingValueType.STRING:
          return await AndroidFlutterSettings.getString(key);
      }
    }

    if (!warmedUpPages.contains(pageId)) {
      for (PageCategoryData category in appData[pageId].categories) {
        for (Preference pref in category.preferences) {
          if (pref.dependencies.isNotEmpty) {
            for (int i = 0; i < pref.dependencies.length; i++) {
              final depObj = pref.dependencies[i];
              if (depObj is PropDependency) {
                setValue(
                  PropKey(depObj.key.name),
                  await AndroidFlutterSettings.getProp(depObj.key),
                );
              } else if (depObj is SettingDependency) {
                var sKey = depObj.key;
                if (getValue(sKey) == null) {
                  setValue(
                    sKey,
                    await getNative(sKey),
                  );
                }
              }
            }
          }
          if (pref is SettingPreference) {
            setValue(
              pref.setting,
              await getNative(pref.setting),
            );
          }
        }
      }
      warmedUpPages.add(pageId);
      notifyListeners();
    }
  }
}

class Notifier<T, K extends BaseKey> {
  T value;
  final K key;

  Notifier._(this.key, this.value);
}

class PropNotifier extends Notifier<String, PropKey> {
  PropNotifier({
    @required PropKey key,
    String value,
  }) : super._(key, value);
}

class SettingNotifier extends Notifier<dynamic, SettingKey> {
  SettingNotifier({
    @required SettingKey key,
    dynamic value,
  }) : super._(key, value);

  SettingNotifier.boolean({
    @required SettingKey<bool> key,
    bool value,
  }) : super._(key, value);

  SettingNotifier.int({
    @required SettingKey<int> key,
    int value,
  }) : super._(key, value);

  SettingNotifier.string({
    @required SettingKey<String> key,
    String value,
  }) : super._(key, value);
}
