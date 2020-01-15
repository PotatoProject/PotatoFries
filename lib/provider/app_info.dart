import 'dart:convert';

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/app_native/resources.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/utils/methods.dart';

class AppInfoProvider extends ChangeNotifier {
  AppInfoProvider() {
    loadData();
  }

  int _pageIndex = 0;
  Color _accentDark = Colors.lightBlueAccent;
  Color _accentLight = Colors.blueAccent;
  Map<String, dynamic> _hostVersion = {
    'MAJOR': 0,
    'MINOR': 0,
    'PATCH': '0',
    'BUILD': 0,
  };

  Map globalSysTheme = Map();

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  set accentDark(Color val) {
    _accentDark = val;
    notifyListeners();
  }

  set accentLight(Color val) {
    _accentLight = val;
    notifyListeners();
  }

  Color get accentDark => _accentDark;

  Color get accentLight => _accentLight;

  int get pageIndex => _pageIndex;

  Map get hostVersion => _hostVersion;

  bool isCompatible(String version) =>
      isVersionCompatible(version, _hostVersion);

  void loadTheme({bool notifyNeeded = true}) async {
    String theme = await AndroidFlutterSettings.getString(
          'theme_customization_overlay_packages',
          SettingType.SECURE,
        ) ??
        '{}';
    globalSysTheme = jsonDecode(theme);
    if (notifyNeeded) notifyListeners();
  }

  void setTheme(String key, String value) async {
    if (value == null)
      globalSysTheme.remove(key);
    else
      globalSysTheme[key] = value;
    print('Setting ' + globalSysTheme.toString());
    await AndroidFlutterSettings.putString(
      'theme_customization_overlay_packages',
      jsonEncode(globalSysTheme),
      SettingType.SECURE,
    );
    notifyListeners();
  }

  int getIconShapeIndex() =>
      shapesPackages.indexOf(globalSysTheme[OVERLAY_CATEGORY_SHAPE]) ?? 0;

  void setIconShape(int index) => setTheme(
        OVERLAY_CATEGORY_SHAPE,
        shapesPackages[index],
      );

  void loadData() async {
    _accentDark = Color(await Resources.getAccentDark());
    _accentLight = Color(await Resources.getAccentLight());
    // Populate version details
    String verNum = await AndroidFlutterSettings.getProp('ro.potato.vernum');
    _hostVersion = parseVerNum(verNum);
    loadTheme(notifyNeeded: false);
    notifyListeners();
  }
}
