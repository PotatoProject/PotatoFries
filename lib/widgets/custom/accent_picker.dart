import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/color_picker_dual.dart';
import 'package:provider/provider.dart';

class AccentPicker extends StatelessWidget {
  bool canDoTheDisco(BuildContext context) {
    var hostVer =
        Provider.of<AppInfoProvider>(context, listen: false).hostVersion;
    var discoMinVer = '3.1.5';
    return isVersionCompatible(discoMinVer, hostVer, strict: true);
  }

  @override
  Widget build(BuildContext context) =>
      // TODO: Clean-up dark light semantic confusion
      ColorPickerDualTile(
        title: 'Accent color',
        subtitle: 'Pick your favourite color!',
        onChange: (dark, light, {ctx}) {},
        defaultDark: Provider.of<AppInfoProvider>(context).accentLight,
        defaultLight: Provider.of<AppInfoProvider>(context).accentDark,
        lightnessDeltaCenter: 0.15,
        lightnessDeltaEnd: 0.6,
        onApply: (String newDark, String newLight) {
          var hostVer =
              Provider.of<AppInfoProvider>(context, listen: false).hostVersion;
          var settingImplVer = '3.1.1';
          var settingImpl = isVersionCompatible(
            settingImplVer,
            hostVer,
            strict: true,
          );
          if (!settingImpl) {
            AndroidFlutterSettings.setProp(
              'persist.sys.theme.accent_dark',
              newDark,
            );
            AndroidFlutterSettings.setProp(
              'persist.sys.theme.accent_light',
              newLight,
            );
          } else {
            AndroidFlutterSettings.putString(
              'sys_accent_light',
              newLight,
              SettingType.SECURE,
            );
            AndroidFlutterSettings.putString(
              'sys_accent_dark',
              newDark,
              SettingType.SECURE,
            );
          }
          AndroidFlutterSettings.reloadAssets('com.android.settings');
          AndroidFlutterSettings.reloadAssets('com.android.systemui');
          Provider.of<AppInfoProvider>(context, listen: false).accentDark =
              Color(int.parse('0xff' + newLight));
          Provider.of<AppInfoProvider>(context, listen: false).accentLight =
              Color(int.parse('0xff' + newDark));
        },
        hasDiscoSetting: canDoTheDisco(context),
      );
}
