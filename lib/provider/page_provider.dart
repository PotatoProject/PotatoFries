import 'dart:convert';
import 'dart:io';

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/utils/custom_widget_registry.dart';
import 'package:potato_fries/utils/utils.dart';

class PageProvider extends ChangeNotifier {
  Map<BaseKey, dynamic> _data = {};

  set data(Map<BaseKey, dynamic> value) {
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
    dumpToFile(await settingsJsonPath);
  }

  void warmupPages() async {
    final fileLoaded = await loadFromFile(await settingsJsonPath);

    if (fileLoaded) notifyListeners();

    for (CustomWidget cw in CustomWidgetRegistry.registry) {
      cw.settings.forEach((setting, defaultValue) async {
        setValue(
          setting,
          await _getNative(setting) ?? defaultValue,
        );
      });
    }

    notifyListeners();

    for (PageData page in appData.pages) {
      for (PageCategoryData category in page.categories) {
        for (Preference pref in category.preferences) {
          for (int i = 0; i < pref.dependencies.length; i++) {
            final depObj = pref.dependencies[i];
            if (depObj is PropDependency) {
              setValue(
                depObj.key,
                await AndroidFlutterSettings.getProp(depObj.key),
              );
            } else if (depObj is SettingDependency) {
              setValue(
                depObj.key,
                await _getNative(depObj.key),
              );
            }
          }

          if (pref is SettingPreference) {
            setValue(
              pref.setting,
              await _getNative(pref.setting) ?? pref.options.defaultValue,
            );
          }
        }
      }

      notifyListeners();
    }
  }

  dynamic _getNative(SettingKey key) async {
    switch (key.valueType) {
      case SettingValueType.BOOLEAN:
        return await AndroidFlutterSettings.getBool(key);
      case SettingValueType.INT:
        return await AndroidFlutterSettings.getInt(key);
      case SettingValueType.STRING:
        return await AndroidFlutterSettings.getString(key);
    }
  }

  int get accentLight => _getAccent('accent_light', Colors.blueAccent.value);

  int get accentDark => _getAccent('accent_dark', Colors.lightBlueAccent.value);

  int _getAccent(String name, int defaultValue) {
    final currentValue = getValue(SettingKey<String>(name, SettingType.SECURE));

    if (currentValue != null) {
      return int.tryParse(currentValue, radix: 16);
    } else {
      return defaultValue;
    }
  }

  set accentLightString(String newColor) =>
      _setAccent('accent_light', newColor);

  set accentDarkString(String newColor) => _setAccent('accent_dark', newColor);

  void _setAccent(String name, String newColor) {
    setValue(
      SettingKey<String>(name, SettingType.SECURE),
      newColor,
    );
  }

  Map<String, dynamic> get globalTheme {
    final stringMap = getValue(SettingKey<String>(
      'theme_customization_overlay_packages',
      SettingType.SECURE,
    ));

    return json.decode(stringMap ?? "{}");
  }

  void setGlobalThemeValue(String category, String value) {
    final globalThemeCopy = Map.from(globalTheme);

    if (value != null) {
      globalThemeCopy[category] = value;
    } else {
      globalThemeCopy.remove(category);
    }

    setValue(
      SettingKey<String>(
        'theme_customization_overlay_packages',
        SettingType.SECURE,
      ),
      json.encode(globalThemeCopy),
    );
  }

  MapEntry<String, String> getIconShape(Map<String, String> shapes) {
    final currentShape = globalTheme[OVERLAY_CATEGORY_SHAPE];

    return MapEntry(currentShape, shapes[currentShape]);
  }

  void setIconShape(String shapePackage) =>
      setGlobalThemeValue(OVERLAY_CATEGORY_SHAPE, shapePackage);

  String getIconShapeLabel(Map<String, String> shapeLabels) {
    final currentShape = globalTheme[OVERLAY_CATEGORY_SHAPE];

    return shapeLabels[currentShape];
  }

  Map<dynamic, dynamic> getIconPackPreview(
      Map<String, Map<dynamic, dynamic>> iconPreviews) {
    return iconPreviews[globalTheme[OVERLAY_CATEGORY_ICON_ANDROID]];
  }

  String getIconPackLabel(Map<String, String> iconLabels) {
    return iconLabels[globalTheme[OVERLAY_CATEGORY_ICON_ANDROID]];
  }

  void setIconPack(String package) {
    List<String> packages = [null, null, null];
    if (package != null) {
      final packageParts = package.split(".")..removeLast();
      final sanitizedPackageName = packageParts.join(".");
      packages = [
        sanitizedPackageName + '.settings',
        sanitizedPackageName + '.systemui',
        sanitizedPackageName + '.android',
      ];
    }
    setGlobalThemeValue(OVERLAY_CATEGORY_ICON_SETTINGS, packages[0]);
    setGlobalThemeValue(OVERLAY_CATEGORY_ICON_SYSUI, packages[1]);
    setGlobalThemeValue(OVERLAY_CATEGORY_ICON_ANDROID, packages[2]);
  }

  String getLsClockPackage() {
    final value = getValue(
      SettingKey<String>(
        "lock_screen_custom_clock_face",
        SettingType.SECURE,
      ),
    );

    bool parsed = true;
    Map<String, dynamic> map = {};

    try {
      map = json.decode(value);
    } catch (e) {
      parsed = false;
    }

    return value != null
        ? parsed
            ? map["clock"]
            : value
        : lockClocks.keys.first;
  }

  String getLsClockLabel() {
    return lockClocks[getLsClockPackage()];
  }

  void setLsClockPackage(String package) async {
    final map = {'clock': package ?? lockClocks.keys.first};

    setValue(
      SettingKey<String>(
        "lock_screen_custom_clock_face",
        SettingType.SECURE,
      ),
      json.encode(map),
    );
  }

  Future<bool> loadFromFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      final fileContent = await file.readAsString();
      Map<String, dynamic> jsonMap = json.decode(fileContent);

      jsonMap.forEach((key, value) {
        final settingKey = Utils.stringToSettingKey(key);
        setValue(settingKey, value);
      });

      return true;
    } else {
      return false;
    }
  }

  Future<void> dumpToFile(String path) async {
    Map<String, dynamic> stringMap = {};
    _data.forEach((key, value) {
      if (key is SettingKey) {
        stringMap.addAll({
          key.toJsonString(): value,
        });
      }
    });

    File file = File(path);

    if (!(await file.exists())) file = await file.create();
    await file.writeAsString(json.encode(stringMap));
  }
}
