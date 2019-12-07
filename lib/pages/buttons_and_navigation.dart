//import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pages/fries_page.dart';
//import 'package:potato_fries/widgets/settings_switch.dart';

class ButtonsAndNavigation extends StatelessWidget {
  final title = 'Navigation';
  final icon = Icons.touch_app;
  final ThemeBloc bloc;

  ButtonsAndNavigation({this.bloc});

  @override
  Widget build(BuildContext context) {
    return FriesPage(
      title: title,
      children: <Widget>[
//        SettingsSwitch(
//          title: 'Cool setting',
//          type: SettingType.SYSTEM,
//          setting: 'cool_setting',
//        ),
      ],
    );
  }
}
