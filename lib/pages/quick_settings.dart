import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class QuickSettings extends StatelessWidget {
  final title = 'Quick Settings';
  final icon = Icons.swap_vertical_circle;
  final ThemeBloc bloc;
  QuickSettings({this.bloc});

  @override
  Widget build(BuildContext context) {
    return FriesPage(
      title: title,
      children: <Widget>[

      ],
    );
  }
}
