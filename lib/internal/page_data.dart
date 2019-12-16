import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/internal/app_info.dart';
import 'package:potato_fries/pagelayout/navigation_page_layout.dart';
import 'package:potato_fries/pagelayout/quick_settings_page_layout.dart';
import 'package:potato_fries/pagelayout/themes_page_layout.dart';
import 'package:potato_fries/pages/buttons_and_navigation.dart';
import 'package:potato_fries/pages/lock_screen.dart';
import 'package:potato_fries/pages/quick_settings.dart';
import 'package:potato_fries/pages/status_bar.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:provider/provider.dart';

List<Widget> pages = [];
ThemeBloc bloc;

Color dark;
Color light;

AppInfoProvider appInfo;

void setPages(BuildContext context, ThemeBloc passedBloc) {
  if (pages.length == 0) {
    bloc = passedBloc;
    pages = [
      QuickSettings(bloc: bloc),
      ButtonsAndNavigation(bloc: bloc),
      Themes(bloc: bloc),
      StatusBar(bloc: bloc),
      LockScreen()
    ];

    QuickSettingsPageLayout().compileProviders(context);
    NavigationPageLayout().compileProviders(context);
    ThemesPageLayout().compileProviders(context);
  }
}

void initAppInfo(BuildContext context) =>
    appInfo = Provider.of<AppInfoProvider>(context);
