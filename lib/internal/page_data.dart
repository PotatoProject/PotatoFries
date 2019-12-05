import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pages/buttons_and_navigation.dart';
import 'package:potato_fries/pages/quick_settings.dart';
import 'package:potato_fries/pages/status_bar.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:potato_fries/pages/lock_screen.dart';

List<Widget> pages = [];
ThemeBloc bloc;

void setPages(ThemeBloc passedBloc) {
  if (pages.length == 0) {
    bloc = passedBloc;
    pages = [
      QuickSettings(bloc: bloc),
      ButtonsAndNavigation(bloc: bloc),
      Themes(bloc: bloc),
      StatusBar(bloc: bloc),
      LockScreen()
    ];
  }
}
