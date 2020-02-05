import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/directory.dart';

class MiscDataProvider extends ChangeNotifier {
  MiscDataProvider() {
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
    for (String categoryKey in appData['misc'].keys) {
      Map curMap = appData['misc'][categoryKey];
      for (String key in curMap.keys) {
        if (curMap[key]['dependencies'] != null) {
          for (int i = 0; i < curMap[key]['dependencies'].length; i++) {
            var depObj = curMap[key]['dependencies'][i];
            var sKey = settingsKey(
              depObj['name'],
              depObj['setting_type'],
            );
            if (getValue(sKey) == null) {
              dynamic getNative() async {
                if (depObj['value'] is bool)
                  return await AndroidFlutterSettings.getBool(
                    depObj['name'],
                    depObj['setting_type'],
                  );
                else if (depObj['value'] is double || depObj['value'] is int)
                  return await AndroidFlutterSettings.getInt(
                    depObj['name'],
                    depObj['setting_type'],
                  );
                else
                  return await AndroidFlutterSettings.getString(
                    depObj['name'],
                    depObj['setting_type'],
                  );
              }

              setValue(sKey, await getNative(), mapSet: true);
            }
          }
        }
        switch (curMap[key]['widget']) {
          case WidgetType.SWITCH:
            setValue(
              settingsKey(key, curMap[key]['setting_type']),
              await AndroidFlutterSettings.getBool(
                key,
                curMap[key]['setting_type'],
              ),
              mapSet: true,
            );
            break;
          case WidgetType.SLIDER:
          case WidgetType.COLOR_PICKER:
            setValue(
              settingsKey(key, curMap[key]['setting_type']),
              await AndroidFlutterSettings.getInt(
                key,
                curMap[key]['setting_type'],
              ),
              mapSet: true,
            );
            break;
          case WidgetType.DROPDOWN:
            setValue(
              settingsKey(key, curMap[key]['setting_type']),
              await AndroidFlutterSettings.getString(
                key,
                curMap[key]['setting_type'],
              ),
              mapSet: true,
            );
            break;
        }
      }
    }
    notifyListeners();
  }
}
