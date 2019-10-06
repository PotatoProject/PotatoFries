import 'package:flutter/material.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class Themes extends StatelessWidget {
  final title = 'Themes';
  final icon = Icons.colorize;

  @override
  Widget build(BuildContext context) {
    return FriesPage(
      title: title,
      children: <Widget>[
        SettingsSwitch(
          title: Text('Cool setting'),
          type: SettingType.SYSTEM,
          setting: 'cool_setting',
        ),
      ],
    );
  }
}
