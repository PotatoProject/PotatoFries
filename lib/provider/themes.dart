import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/directory.dart';

class ThemesDataProvider extends ChangeNotifier {
  ThemesDataProvider() {
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
    for (String categoryKey in appData['themes'].keys) {
      Map curMap = appData['themes'][categoryKey];
      for (String key in curMap.keys) {
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
