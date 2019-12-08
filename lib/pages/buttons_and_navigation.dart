//import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pagelayout/navigation_page_layout.dart';
import 'package:potato_fries/pages/fries_page.dart';

class ButtonsAndNavigation extends StatelessWidget {
  final title = 'Navigation';
  final icon = Icons.touch_app;
  final ThemeBloc bloc;

  final int keyIndex;

  ButtonsAndNavigation({
    this.bloc,
    this.keyIndex,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> builtLayout =
        NavigationPageLayout().build(context, keyIndex);
    List<GlobalKey> keys = builtLayout["keys"];
    List<Widget> children = builtLayout["body"];

    Future.delayed(
      Duration.zero,
      () async {
        if (keyIndex != null) {
          Scrollable.ensureVisible(keys[keyIndex].currentContext);
        }
      },
    );

    if (keyIndex != null) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: FriesPage(
          title: title,
          children: children,
          showActions: keyIndex == null,
        ),
      );
    } else {
      return FriesPage(title: title, children: children);
    }
  }
}
