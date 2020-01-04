import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:potato_fries/widgets/color_picker_dual.dart';

String settingsKey(String setting, SettingType type) =>
    splitSettingType(type) + ':' + setting;

String splitSettingType(SettingType type) => type.toString().split('.')[1];

SettingType sType2Enum(String s) => SettingType.values.firstWhere(
      (st) => st.toString() == ('SettingType.' + s),
    );

void showColorPicker(
  BuildContext context, {
  Function onApply,
  Function onChange,
  double lightnessMin = 0,
  double lightnessMax = 1,
  Color defaultColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => ColorPicker(
      onApply: onApply,
      lightnessMin: lightnessMin,
      lightnessMax: lightnessMax,
      defaultColor: defaultColor,
    ),
  );
}

void showColorPickerDual(
  BuildContext context, {
  bool lightnessLocked = false,
  double lightnessDeltaCenter = 0,
  double lightnessDeltaEnd = 0,
  double lightnessMin = 0,
  double lightnessMax = 1,
  Function onApply,
  Function onChange,
  Color defaultDark,
  Color defaultLight,
  Color defaultColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => ColorPickerDual(
      lightnessLocked: lightnessLocked,
      lightnessDeltaCenter: lightnessDeltaCenter,
      lightnessDeltaEnd: lightnessDeltaEnd,
      onApply: onApply,
      onChange: onChange,
      defaultDark: defaultDark,
      defaultLight: defaultLight,
      defaultColor: defaultColor,
    ),
  );
}

Map<String, dynamic> parseVerNum(String vernum) {
  Map<String, dynamic> ret = Map();
  String build;
  String version;
  if (vernum.contains('+')) {
    version = vernum.split('+')[0];
    build = vernum.split('+')[1];
  } else {
    version = vernum;
    build = '0';
  }
  ret['MAJOR'] = (int.tryParse(version.split('.')[0]));
  ret['MINOR'] = (int.tryParse(version.split('.')[1]));
  ret['PATCH'] = version.split('.')[2];
  ret['BUILD'] = (int.tryParse(build));
  return ret;
}

bool isVersionCompatible(String target, dynamic hostVersion) {
  Map<String, dynamic> targetVersion = parseVerNum(target);
  if (hostVersion is String) {
    hostVersion = parseVerNum(hostVersion);
  }
  int _targetPatch = getNum(targetVersion['PATCH']);
  int _hostPatch = getNum(hostVersion['PATCH']);
  return hostVersion['MAJOR'] >= targetVersion['MAJOR'] &&
      hostVersion['MINOR'] >= targetVersion['MINOR'] &&
      _hostPatch >= _targetPatch;
  ;
}

bool isNumber(String item) => '0123456789'.split('').contains(item);

int getNum(String ip) {
  List l = List.from(ip.split(''));
  l.removeWhere((c) => !isNumber(c));
  return int.tryParse(l.join());
}
