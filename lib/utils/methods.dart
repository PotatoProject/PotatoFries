import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/widgets/color_picker.dart';

String settingsKey(String setting, SettingType type) =>
    splitSettingType(type) + ':' + setting;

String splitSettingType(SettingType type) => type.toString().split('.')[1];

SettingType sType2Enum(String s) =>
    SettingType.values.firstWhere(
          (st) => st.toString() == ('SettingType.' + s),
    );

void showColorPicker(BuildContext context, {
  Function onApply,
  Function onChange,
  double lightnessMin = 0,
  double lightnessMax = 1,
  Color defaultColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) =>
        ColorPicker(
          onApply: onApply,
          lightnessMin: lightnessMin,
          lightnessMax: lightnessMax,
          defaultColor: defaultColor,
        ),
  );
}