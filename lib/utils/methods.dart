import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:potato_fries/widgets/color_picker_dual.dart';

String settingsKey(String setting, SettingType type) =>
    splitSettingType(type) + ':' + setting;

String splitSettingType(SettingType type) => type.toString().split('.')[1];

SettingType sType2Enum(String s) => SettingType.values.firstWhere(
      (st) => st.toString() == ('SettingType.' + s),
    );

void showNavigationSheet({
  BuildContext context,
  AppInfoProvider provider,
  Map<String, IconData> items,
  Function(int index) onTap,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        items.length,
        (index) => ListTile(
          leading: Icon(
            items.values.toList()[index],
            color: provider.pageIndex == index
                ? Theme.of(context).accentColor
                : Theme.of(context).iconTheme.color,
          ),
          title: Text(
            items.keys.toList()[index],
            style: TextStyle(
              color: provider.pageIndex == index
                  ? Theme.of(context).accentColor
                  : Theme.of(context).iconTheme.color,
            ),
          ),
          onTap: () {
            onTap(index);
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}

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
  bool hasDiscoSetting = false,
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
      hasDiscoSetting: hasDiscoSetting,
    ),
  );
}

Map<String, dynamic> parseVerNum(String vernum) {
  var exp = RegExp(
      r"^((([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)$");
  if (!exp.hasMatch(vernum)) return null;
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
  assert(isVersionValid(ret));
  return ret;
}

String verNumString(Map ver) => isVersionValid(ver)
    ? "${ver['MAJOR']}.${ver['MINOR']}.${ver['PATCH']}+${ver['BUILD']}"
    : null;

bool isVersionCompatible(
  String target,
  dynamic hostVersion, {
  String max,
  bool strict = false,
}) {
  Map<String, dynamic> targetVersion = parseVerNum(target);
  Map<String, dynamic> maxVersion;
  if (max != null) maxVersion = parseVerNum(max);
  if (hostVersion is String) {
    hostVersion = parseVerNum(hostVersion);
  }
  int _targetPatch = getNum(targetVersion['PATCH']);
  int _hostPatch = getNum(hostVersion['PATCH']);
  return hostVersion['MAJOR'] >= targetVersion['MAJOR'] &&
      hostVersion['MINOR'] >= targetVersion['MINOR'] &&
      _hostPatch >= _targetPatch &&
      (maxVersion == null ||
          (hostVersion['MAJOR'] <= maxVersion['MAJOR'] &&
              hostVersion['MINOR'] <= maxVersion['MINOR'] &&
              _hostPatch <= getNum(maxVersion['PATCH'])));
}

Future<bool> checkCompat(Map compat) async {
  if (compat['prop'] != null) {
    String propData = await AndroidFlutterSettings.getProp(compat['prop']);
    return compat['values'] == null
        ? (propData == 'true' || propData == '1')
        : compat['values'].contains(propData);
  }
  return false;
}

bool isNumber(String item) => '0123456789'.split('').contains(item);

int getNum(String ip) {
  List l = List.from(ip.split(''));
  l.removeWhere((c) => !isNumber(c));
  return int.tryParse(l.join());
}

bool isVersionValid(Map ver) => (ver != null &&
    (ver.containsKey('MAJOR') && ver['MAJOR'] is int) &&
    (ver.containsKey('MINOR') && ver['MINOR'] is int) &&
    (ver.containsKey('PATCH') && ver['PATCH'] is String) &&
    (ver.containsKey('BUILD') && ver['BUILD'] is int));
