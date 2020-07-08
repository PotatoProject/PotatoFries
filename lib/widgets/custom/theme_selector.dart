import 'package:flutter/material.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:provider/provider.dart';
import 'package:potato_fries/provider/app_info.dart';

class ThemeSelector extends StatefulWidget {
  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  List<String> themesTitle = [
    'Default theme',
    'Dark',
    'Night',
    'Style',
  ];

  List<String> themesPackages = [
    'package_device_default',
    'com.android.dark.darkgray',
    'com.android.dark.night',
    'com.android.dark.style',
  ];
  Map<String, int> titleColorMap = {
    'Default theme': -16777216,
    'Dark': -15395304,
    'Night': -13223868,
    'Style': -14669773,
  };

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<AppInfoProvider>(context);
    return SizeableListTile(
      title: 'Theme',
      subtitle: Text(
        titleColorMap.keys.firstWhere(
            (k) => titleColorMap[k] == _provider.background,
            orElse: () => null),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: themesTitle.map((f) {
                  return ListTile(
                    leading: Opacity(
                      opacity:
                          _provider.background == titleColorMap[f] ? 1.0 : 0.0,
                      child: Icon(Icons.check,
                          color: Theme.of(context).accentColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    title: Text(
                      f,
                      style: _provider.background == titleColorMap[f]
                          ? TextStyle(
                              color: Theme.of(context).accentColor,
                            )
                          : TextStyle(),
                    ),
                    onTap: () {
                      AndroidFlutterSettings.putString(
                        'color_bucket_overlay',
                        themesPackages[themesTitle.indexOf(f)],
                        SettingType.SYSTEM,
                      );
                      _provider.setBackground(titleColorMap[f]);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      icon: Icon(
        Icons.palette,
      ),
    );
  }
}
