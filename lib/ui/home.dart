import 'package:flutter/material.dart';
import 'package:potato_fries/pages/qs.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/custom_bottom_bar.dart';
import 'package:provider/provider.dart';

class FriesHome extends StatefulWidget {
  @override
  _FriesHomeState createState() => _FriesHomeState();
}

class _FriesHomeState extends State<FriesHome> {
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
              return Container();
            case 3:
              return Container();
            case 4:
              return Container();
            case 5:
              return Container();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
