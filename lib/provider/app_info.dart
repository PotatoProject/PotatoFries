import 'dart:convert';

import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/app_native/resources.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/data/debugging.dart';
import 'package:potato_fries/data/models.dart';
import 'package:effectsplugin/effectsplugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfoProvider extends ChangeNotifier {
  AppInfoProvider() {
    loadData();
  }

  EFFECT_TYPE audioFxType = EFFECT_TYPE.NONE;
  final _debug = Debug();

  int _pageIndex = 0;
  Map<String, String> _shapes = {};
  Map<String, String> _shapeLabels = {};
  Map<String, Map<dynamic, dynamic>> _iconPreviews = {};
  Map<String, String> _iconLabels = {};
  Color _accentDark = Colors.lightBlueAccent;
  Color _accentLight = Colors.blueAccent;
  SharedPreferences _prefs;
  BuildVersion _hostVersion = BuildVersion.empty;
  String device;
  String model;
  String exactBuild;
  String dish;
  String type;

  bool _flag1 = false;
  int _flag2 = 0;
  bool _flag3 = false;
  bool _flag4 = false;

  Map<String, dynamic> globalSysTheme = {};

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

  void setFlag1() {
    _flag1 = !_flag1;
    if (!_flag1) _resetFlags();
    notifyListeners();
  }

  void _resetFlags() {
    _flag1 = false;
    _flag2 = 0;
    _flag3 = false;
    // flag4 controls disco settings. Do not reset!
  }

  set flag2(int val) {
    _flag2 = val;
    if (!_flag1) {
      _flag2 = 0;
      return;
    }
    if (val == 0 || val > 5) _resetFlags();
    notifyListeners();
  }

  void setFlag3() {
    if (!_flag3) {
      _flag3 = true;
      notifyListeners();
    }
  }

  void setFlag4() async {
    if (_flag2 == 3 && !_flag4) {
      _flag4 = isCompatible(threeDotOneDotSeven);
      if (_flag4) {
        await AndroidFlutterSettings.setPropByName(
          'persist.sys.theme.accent_disco',
          '0',
        );
        notifyListeners();
      }
    }
  }

  void loadFlag4() async {
    if (isCompatible(threeDotOneDotSeven)) {
      var _disco = await AndroidFlutterSettings.getPropByName(
              'persist.sys.theme.accent_disco') ??
          "";
      _flag4 = _disco != "";
    }
  }

  bool _autoCalculateAccents = true;

  bool get autoCalculateAccents => _autoCalculateAccents;

  set autoCalculateAccents(bool autoCalculateAccents) {
    _autoCalculateAccents = autoCalculateAccents;
    _prefs.setBool("ACCENT_AUTO", autoCalculateAccents);
  }

  Map<String, String> get shapes => _shapes;

  List<String> get shapePackages => _shapes.keys.toList();

  Map<String, String> get shapeLabels => _shapeLabels;

  Map<String, Map<dynamic, dynamic>> get iconPreviews => _iconPreviews;

  List<String> get iconPackages => _iconLabels.keys.toList();

  Map<String, String> get iconLabels => _iconLabels;

  Color get accentDark => _accentDark;

  Color get accentLight => _accentLight;

  int get pageIndex => _pageIndex;

  BuildVersion get hostVersion => _debug.versionSpoof ?? _hostVersion;

  bool get flag1 => _flag1;

  int get flag2 => _flag2;

  bool get flag3 => _flag3;

  bool get flag4 => _flag4 && isCompatible(threeDotOneDotSeven);

  bool get audioFxSupported => audioFxType != EFFECT_TYPE.NONE;

  bool isCompatible(BuildVersion version, {BuildVersion max}) =>
      (_debug.versionCheckDisabled) ||
      VersionConstraint(
        min: hostVersion,
        max: max ?? BuildVersion.empty,
      ).isConstrained(version);

  void loadTheme({bool notifyNeeded = true}) async {
    String theme = await AndroidFlutterSettings.getString(
          SettingKey(
            'theme_customization_overlay_packages',
            SettingType.SECURE,
          ),
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
    await AndroidFlutterSettings.putString(
      SettingKey(
        'theme_customization_overlay_packages',
        SettingType.SECURE,
      ),
      jsonEncode(globalSysTheme),
    );
    notifyListeners();
  }

  MapEntry<String, String> getIconShape() {
    return MapEntry(
      globalSysTheme[OVERLAY_CATEGORY_SHAPE],
      shapes[globalSysTheme[OVERLAY_CATEGORY_SHAPE]],
    );
  }

  String getShapeLabel() {
    return _shapeLabels[globalSysTheme[OVERLAY_CATEGORY_SHAPE]];
  }

  void setIconShape(int index) => setTheme(
        OVERLAY_CATEGORY_SHAPE,
        shapePackages[index],
      );

  Map<dynamic, dynamic> getIconPackPreview() {
    return _iconPreviews[globalSysTheme[OVERLAY_CATEGORY_ICON_ANDROID]];
  }

  String getIconPackLabel() {
    return _iconLabels[globalSysTheme[OVERLAY_CATEGORY_ICON_ANDROID]];
  }

  void setIconPack(int index) {
    List<String> packages = [null, null, null];
    if (index >= iconPackages.length) {
      throw Exception("Invalid iconPack index: $index!");
    } else {
      if (index > 0) {
        final packageParts = iconPackages[index].split(".")..removeLast();
        final sanitizedPackageName = packageParts.join(".");
        packages = [
          sanitizedPackageName + '.settings',
          sanitizedPackageName + '.systemui',
          sanitizedPackageName + '.android',
        ];
      }
    }
    setTheme(OVERLAY_CATEGORY_ICON_SETTINGS, packages[0]);
    setTheme(OVERLAY_CATEGORY_ICON_SYSUI, packages[1]);
    setTheme(OVERLAY_CATEGORY_ICON_ANDROID, packages[2]);
  }

  // App _debug API
  String setVersionOverride(BuildVersion newVer) {
    String ret;

    if (newVer != null) {
      _debug.versionSpoof = newVer;
    } else {
      _debug.versionSpoof = null;
      ret = "Invalid version! Disabling override.";
    }

    loadFlag4();
    notifyListeners();
    return ret;
  }

  BuildVersion getVersionOverride() => _debug.versionSpoof;

  void setVersionCheckDisabled(bool disable) {
    _debug.versionCheckDisabled = disable;
    loadFlag4();
    notifyListeners();
  }

  bool isVersionCheckDisabled() => _debug.versionCheckDisabled;

  void setCompatCheckDisabled(bool disable) {
    _debug.compatCheckDisabled = disable;
    loadFlag4();
    notifyListeners();
  }

  bool isCompatCheckDisabled() => _debug.compatCheckDisabled;

  void loadData() async {
    _prefs = await SharedPreferences.getInstance();
    _autoCalculateAccents = _prefs.getBool("ACCENT_AUTO") ?? true;
    _accentDark = Color(await Resources.getAccentDark()).withOpacity(1);
    _accentLight = Color(await Resources.getAccentLight()).withOpacity(1);
    _shapes = await Resources.getShapes();
    _shapeLabels = await Resources.getShapeLabels();
    _iconPreviews = await Resources.getIconsWithPreviews();
    _iconLabels = await Resources.getIconsWithLabels();
    // Populate version details
    String verNum =
        await AndroidFlutterSettings.getPropByName('ro.potato.vernum');
    _hostVersion = BuildVersion.parse(verNum);
    loadTheme(notifyNeeded: false);
    device = await AndroidFlutterSettings.getPropByName('ro.potato.device');
    model = await AndroidFlutterSettings.getPropByName('ro.product.model');
    exactBuild =
        await AndroidFlutterSettings.getPropByName('ro.potato.version');
    dish = await AndroidFlutterSettings.getPropByName('ro.potato.dish');
    switch (await AndroidFlutterSettings.getPropByName(
        'ro.potato.branding.version')) {
      case "Official":
        type = "Official";
        break;
      case "Mashed":
        type = "Mashed (Official Beta)";
        break;
      default:
        type = "Community";
    }
    loadFlag4();
    if (await FX.mDirac.isDiracSupported()) {
      audioFxType = EFFECT_TYPE.DIRAC;
    } else if (await FX.mMi.isMiSupported()) {
      audioFxType = EFFECT_TYPE.MI;
    }
    notifyListeners();
  }
}
