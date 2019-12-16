import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/pagelayout/page_layout.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/color_picker_tile.dart';
import 'package:potato_fries/ui/section.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class ThemesPageLayout extends PageLayout {
  @override
  int get categoryIndex => 2;

  @override
  List<Widget> body(BuildContext context, {BaseDataProvider provider}) => [
        Section(title: "Colors", children: <Widget>[
          ColorPickerTile(
            title: 'Accent color',
            subtitle: 'Pick your favourite color!',
            defaultDark: dark,
            defaultLight: light,
            lightnessDeltaCenter: 0.15,
            lightnessDeltaEnd: 0.6,
            onApply: (String newDark, String newLight) {
              AndroidFlutterSettings.setProp(
                'persist.sys.theme.accent_dark',
                newDark,
              );
              AndroidFlutterSettings.setProp(
                'persist.sys.theme.accent_light',
                newLight,
              );
              setColors(context);
              AndroidFlutterSettings.reloadAssets('com.android.settings');
              AndroidFlutterSettings.reloadAssets('com.android.systemui');
            },
          ),
        ]),
      ];
}
