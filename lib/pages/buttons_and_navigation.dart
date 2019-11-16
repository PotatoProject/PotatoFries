import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class ButtonsAndNavigation extends StatelessWidget {
  final title = 'Buttons and navigation';
  final icon = Icons.touch_app;
  final ThemeBloc bloc;
  ButtonsAndNavigation({this.bloc});

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
