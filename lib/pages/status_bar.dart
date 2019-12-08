import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pages/fries_page.dart';

//import 'package:potato_fries/widgets/settings_slider.dart';
//import 'package:potato_fries/widgets/settings_switch.dart';

class StatusBar extends StatelessWidget {
  final title = 'Status Bar';
  final icon = Icons.space_bar;
  final ThemeBloc bloc;

  StatusBar({this.bloc});

  @override
  Widget build(BuildContext context) {
    return FriesPage(
      title: title,
      children: <Widget>[],
    );
  }
}
