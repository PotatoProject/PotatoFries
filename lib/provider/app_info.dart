import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/utils/resources.dart';
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

  int get pageIndex => _pageIndex;

  BuildVersion get hostVersion => _debug.versionSpoof ?? _hostVersion;

  bool get flag1 => _flag1;

  int get flag2 => _flag2;

  bool get flag3 => _flag3;

  bool get flag4 => _flag4 && isCompatible(threeDotOneDotSeven);

  bool get audioFxSupported => audioFxType != EFFECT_TYPE.NONE;

  bool get debugPhase1 => _flag1;

  bool get debugPhase2 => _flag2 == 5;

  bool get debugPhase3 => _flag3;

  bool get debugEnabled =>
      (debugPhase1 && debugPhase2 && debugPhase3) || kDebugMode;

  bool isCompatible(BuildVersion version, {BuildVersion max}) =>
      (_debug.versionCheckDisabled) ||
      VersionConstraint(
        min: hostVersion,
        max: max ?? BuildVersion.empty,
      ).isConstrained(version);

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
    _shapes = await Resources.getShapes();
    _shapeLabels = await Resources.getShapeLabels();
    _iconPreviews = await Resources.getIconsWithPreviews();
    _iconLabels = await Resources.getIconsWithLabels();
    // Populate version details
    String verNum =
        await AndroidFlutterSettings.getPropByName('ro.potato.vernum');
    _hostVersion = BuildVersion.parse(verNum);
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
