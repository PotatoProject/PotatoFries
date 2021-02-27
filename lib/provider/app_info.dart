import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:potato_fries/utils/resources.dart';
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

  PackageInfo _packageInfo;
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

  int _debugFlagTap = 0;

  Map<String, dynamic> globalSysTheme = {};

  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }

  set debugFlagTap(int val) {
    _debugFlagTap = val.clamp(0, 10);

    notifyListeners();
  }

  bool _autoCalculateAccents = true;

  bool get autoCalculateAccents => _autoCalculateAccents;

  set autoCalculateAccents(bool autoCalculateAccents) {
    _autoCalculateAccents = autoCalculateAccents;
    _prefs.setBool("ACCENT_AUTO", autoCalculateAccents);
  }

  bool __discoEasterEnabled = false;

  set _discoEasterEnabled(bool discoEasterEnabled) {
    __discoEasterEnabled = discoEasterEnabled;
    _prefs.setBool("DISCO_EASTER", __discoEasterEnabled);
  }

  bool get discoEasterEnabled => __discoEasterEnabled;

  toggleDisco() {
    // If disco was on, make sure to turn it off before disabling easter enable
    if (__discoEasterEnabled && _discoEasterActive) discoEasterActive = false;
    if (!VersionConstraint(min: BuildVersion(4, 0, 4))
            .isConstrained(_hostVersion) &&
        !_debug.versionCheckDisabled) {
      discoEasterActive = false;
      _discoEasterEnabled = false;
      return;
    }
    _discoEasterEnabled = !__discoEasterEnabled;
    notifyListeners();
  }

  bool _discoEasterActive = false;

  bool get discoEasterActive => _discoEasterActive;

  set discoEasterActive(bool discoEasterActive) {
    _discoEasterActive = discoEasterActive;
    AndroidFlutterSettings.putBool(
        SettingKey<bool>(
          'accent_disco',
          SettingType.SECURE,
        ),
        discoEasterActive);
    notifyListeners();
  }


  PackageInfo get packageInfo => _packageInfo;

  Map<String, String> get shapes => _shapes;

  List<String> get shapePackages => _shapes.keys.toList();

  Map<String, String> get shapeLabels => _shapeLabels;

  Map<String, Map<dynamic, dynamic>> get iconPreviews => _iconPreviews;

  List<String> get iconPackages => _iconLabels.keys.toList();

  Map<String, String> get iconLabels => _iconLabels;

  int get pageIndex => _pageIndex;

  BuildVersion get hostVersion => _debug.versionSpoof ?? _hostVersion;

  int get debugFlagTap => _debugFlagTap;

  bool get audioFxSupported => audioFxType != EFFECT_TYPE.NONE;

  bool get debugEnabled => _debugFlagTap == 10 || isBuildDebug();

  bool isBuildDebug() {
      // ignore: non_constant_identifier_names
      var DEBUG = false;
      assert(DEBUG = true);
      return DEBUG;
  }

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

    notifyListeners();
    return ret;
  }

  BuildVersion getVersionOverride() => _debug.versionSpoof;

  void setVersionCheckDisabled(bool disable) {
    _debug.versionCheckDisabled = disable;
    notifyListeners();
  }

  bool isVersionCheckDisabled() => _debug.versionCheckDisabled;

  void setCompatCheckDisabled(bool disable) {
    _debug.compatCheckDisabled = disable;
    notifyListeners();
  }

  bool isCompatCheckDisabled() => _debug.compatCheckDisabled;

  void loadData() async {
    _prefs = await SharedPreferences.getInstance();
    _autoCalculateAccents = _prefs.getBool("ACCENT_AUTO") ?? true;
    __discoEasterEnabled = _prefs.getBool("DISCO_EASTER") ?? false;
    _discoEasterActive = await AndroidFlutterSettings.getBool(SettingKey<bool>(
          'accent_disco',
          SettingType.SECURE,
        )) ??
        false;
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
    if (await FX.mDirac.isDiracSupported()) {
      audioFxType = EFFECT_TYPE.DIRAC;
    } else if (await FX.mMi.isMiSupported()) {
      audioFxType = EFFECT_TYPE.MI;
    }
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}
