import 'package:flutter/material.dart';
import 'package:potato_fries/pages/buttons.dart';
import 'package:potato_fries/pages/lock_screen.dart';
import 'package:potato_fries/pages/qs.dart';
import 'package:potato_fries/pages/status_bar.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/custom_bottom_bar.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:provider/provider.dart';

class FriesHome extends StatefulWidget {
  @override
  _FriesHomeState createState() => _FriesHomeState();
}

class _FriesHomeState extends State<FriesHome> {
  @override
  void initState() {
    registerCustomWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppInfoProvider>(context);
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(
        currentIndex: provider.pageIndex,
        onTap: (index) => provider.pageIndex = index,
        items: [
          Icon(Icons.swap_vertical_circle),
          Icon(Icons.touch_app),
          Icon(Icons.colorize),
          Icon(Icons.space_bar),
          Icon(Icons.lock),
        ],
      ),
      body: Builder(
        builder: (context) {
          int i = provider.pageIndex + 1;
          switch (i) {
            case 1:
              return QuickSettings();
            case 2:
              return Buttons();
            case 3:
              return Themes();
            case 4:
              return StatusBar();
            case 5:
              return LockScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
