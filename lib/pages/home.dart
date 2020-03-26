import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/pages/buttons.dart';
import 'package:potato_fries/pages/lock_screen.dart';
import 'package:potato_fries/pages/misc.dart';
import 'package:potato_fries/pages/qs.dart';
import 'package:potato_fries/pages/status_bar.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/custom_bottom_bar.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:provider/provider.dart';
import 'package:spicy_components/spicy_components.dart';

import '../data/constants.dart';

class FriesHome extends StatefulWidget {
  @override
  _FriesHomeState createState() => _FriesHomeState();
}

class _FriesHomeState extends State<FriesHome> {
  PageController pageController =
      PageController(initialPage: 0, keepPage: false);
  @override
  void initState() {
    registerCustomWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppInfoProvider>(context);
    return Scaffold(
      bottomNavigationBar: SpicyBottomBar(
        leftItems: [
          IconButton(
            icon: Icon(Icons.menu),
            padding: EdgeInsets.all(0),
            onPressed: () {},
          ),
          Text(
            pageLabels[provider.pageIndex],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).iconTheme.color.withOpacity(0.7),
            ),
          ),
        ],
        rightItems: [
          IconButton(
            icon: Icon(MdiIcons.accountGroupOutline),
            padding: EdgeInsets.all(0),
            onPressed: () {},
          ),
        ],
      ),
      /*bottomNavigationBar: CustomBottomBar(
        currentIndex: provider.pageIndex,
        onTap: (index) {
          provider.pageIndex = index;
          pageController.jumpToPage(provider.pageIndex);
        },
        items: [
          Icon(Icons.swap_vertical_circle),
          Icon(Icons.touch_app),
          Icon(Icons.colorize),
          Icon(Icons.space_bar),
          Icon(Icons.lock),
          Icon(Icons.star)
        ],
      ),*/
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          QuickSettings(),
          Buttons(),
          Themes(),
          StatusBar(),
          LockScreen(),
          Misc(),
        ],
      ),
    );
  }
}
