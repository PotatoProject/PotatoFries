import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/utils/methods.dart';

class PageProvider extends ChangeNotifier {
  final String providerKey;

  PageProvider(this.providerKey) {
    loadData();
  }

  Map<String, dynamic> _data = Map();

  set data(Map<String, dynamic> value) {
    _data = value;
    notifyListeners();
  }

  Map<String, dynamic> get data => _data;

  dynamic getValue(String key) => _data[key];

  void setValue(String key, dynamic value, {bool mapSet = false}) async {
    if (!mapSet) {
      if (value is int || value is double) {
        await AndroidFlutterSettings.putInt(
          key.split(':')[1],
          value.toInt(),
          sType2Enum(key.split(':')[0]),
        );
      } else if (value is bool) {
        await AndroidFlutterSettings.putBool(
          key.split(':')[1],
          value,
          sType2Enum(key.split(':')[0]),
        );
      } else if (value is String) {
        await AndroidFlutterSettings.putString(
          key.split(':')[1],
          value,
          sType2Enum(key.split(':')[0]),
        );
      }
    }
    _data[key] = value;
    notifyListeners();
  }

  void loadData() async {
    for (String categoryKey in appData[this.providerKey].keys) {
      List<Preference> curMap = appData[this.providerKey][categoryKey];
      for (Preference pref in curMap) {
        if (pref.dependencies.isNotEmpty) {
          for (int i = 0; i < pref.dependencies.length; i++) {
            final depObj = pref.dependencies[i];
            if (depObj is PropDependency) {
              var val = await checkCompat(depObj);
              setValue(
                settingsKey("${depObj.name}~COMPAT", SettingType.SYSTEM),
                val,
                mapSet: true,
              );
              if (!val) continue;
            } else if (depObj is SettingDependency) {
              var sKey = settingsKey(
                depObj.name,
                depObj.type,
              );
              if (getValue(sKey) == null) {
                dynamic getNative() async {
                  switch (depObj.valType) {
                    case SettingValueType.BOOLEAN:
                      return await AndroidFlutterSettings.getBool(
                        depObj.name,
                        depObj.type,
                      );
                    case SettingValueType.INT:
                      return await AndroidFlutterSettings.getInt(
                        depObj.name,
                        depObj.type,
                      );
                    case SettingValueType.STRING:
                      return await AndroidFlutterSettings.getString(
                        depObj.name,
                        depObj.type,
                      );
                  }
                }

                setValue(sKey, await getNative(), mapSet: true);
              }
            }
          }
        }
        if (pref is SettingPreference) {
          switch (pref.valueType) {
            case SettingValueType.BOOLEAN:
              setValue(
                settingsKey(pref.setting, pref.type),
                await AndroidFlutterSettings.getBool(
                  pref.setting,
                  pref.type,
                ),
                mapSet: true,
              );
              break;
            case SettingValueType.INT:
              setValue(
                settingsKey(pref.setting, pref.type),
                await AndroidFlutterSettings.getInt(
                  pref.setting,
                  pref.type,
                ),
                mapSet: true,
              );
              break;
            case SettingValueType.STRING:
              setValue(
                settingsKey(pref.setting, pref.type),
                await AndroidFlutterSettings.getString(
                  pref.setting,
                  pref.type,
                ),
                mapSet: true,
              );
              break;
          }
        }
      }
    }
    notifyListeners();
  }
}
