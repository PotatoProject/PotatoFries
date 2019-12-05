import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/internal/methods.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/pagelayout/page_layout.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class ThemesPageLayout extends PageLayout {
  @override
  List<Widget> body(BuildContext context) => [
    SizeableListTile(
      title: 'Accent color',
      subtitle: 'Pick your favourite color!',
      icon: Icon(Icons.color_lens),
      onTap: () => showColorPicker(
        context,
        lightnessLocked: true,
        onChange: (Color color) => bloc.changeAccent(color),
        onApply: (String dark, String light) {
          AndroidFlutterSettings.setProp(
            'persist.sys.theme.accent_dark',
            dark,
          );
          AndroidFlutterSettings.setProp(
            'persist.sys.theme.accent_light',
            light,
          );
        },
      ),
    ),
  ];
}