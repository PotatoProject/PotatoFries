import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:potato_fries/widgets/color_picker_dual.dart';
import 'package:url_launcher/url_launcher.dart';

String settingsKey(String setting, SettingType type) =>
    splitSettingType(type) + ':' + setting;

String splitSettingType(SettingType type) => type.toString().split('.')[1];

SettingType sType2Enum(String s) => SettingType.values.firstWhere(
      (st) => st.toString() == ('SettingType.' + s),
    );

void showNavigationSheet({
  BuildContext context,
  AppInfoProvider provider,
  List<BasePage> items,
  Function(int index) onTap,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        items.length,
        (index) => ListTile(
          leading: Icon(
            items[index].icon,
            color: provider.pageIndex == index
                ? Theme.of(context).accentColor
                : Theme.of(context).iconTheme.color,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24),
          title: Text(
            items[index].title,
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
  // Check equality of major. We may not support a 3.x feature on 4.x, say.
  bool ret = (hostVersion['MAJOR'] == targetVersion['MAJOR']) &&
      ((hostVersion['MINOR'] > targetVersion['MINOR']) ||
          (hostVersion['MINOR'] == targetVersion['MINOR'] &&
              _hostPatch >= _targetPatch));
  if (maxVersion != null) {
    ret = ret &&
        !(hostVersion['MAJOR'] > maxVersion['MAJOR'] ||
            (hostVersion['MAJOR'] == maxVersion['MAJOR'] &&
                (hostVersion['MINOR'] > maxVersion['MINOR'] ||
                    (hostVersion['MINOR'] == maxVersion['MINOR'] &&
                        _hostPatch <= getNum(maxVersion['PATCH'])))));
  }
  return ret;
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

void reloadSystemElements() {
  var reload = [
    'com.android.settings',
    'com.android.systemui',
    'android',
  ];
  for (var r in reload) AndroidFlutterSettings.reloadAssets(r);
}

void launchUrl(String url, {BuildContext context}) async {
  if (await canLaunch(url))
    await launch(url);
  else {
    if (context != null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open $url!'),
        ),
      );
    }
  }
}
