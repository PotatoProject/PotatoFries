import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/color_picker_dual.dart';
import 'package:provider/provider.dart';

class AccentPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ColorPickerDualTile(
        title: 'Accent color',
        subtitle: 'Pick your favourite color!',
        onChange: (dark, light, {ctx}) {},
        defaultDark: Provider.of<AppInfoProvider>(context).accentLight,
        defaultLight: Provider.of<AppInfoProvider>(context).accentDark,
        lightnessDeltaCenter: 0.15,
        lightnessDeltaEnd: 0.6,
        onApply: (String newDark, String newLight) {
          Future.delayed(Duration.zero, () {
            AndroidFlutterSettings.putString(
              'accent_light',
              newLight,
              SettingType.SECURE,
            );
            AndroidFlutterSettings.putString(
              'accent_dark',
              newDark,
              SettingType.SECURE,
            );
          });
          Provider.of<AppInfoProvider>(context, listen: false).accentDark =
              Color(int.parse('0xff' + newLight));
          Provider.of<AppInfoProvider>(context, listen: false).accentLight =
              Color(int.parse('0xff' + newDark));
        },
        hasDiscoSetting: Provider.of<AppInfoProvider>(context).flag4,
      );
}
