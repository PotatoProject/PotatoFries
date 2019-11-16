import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/widgets/settings_slider.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class StatusBar extends StatelessWidget {
  final title = 'Status Bar';
  final icon = Icons.space_bar;
  final ThemeBloc bloc;

  StatusBar({this.bloc});

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
        SettingsSlider(
          title: Text('Cool slider'),
          type: SettingType.SECURE,
          setting: 'cool_setting',
          initial: 0,
        ),
      ],
    );
  }
}
