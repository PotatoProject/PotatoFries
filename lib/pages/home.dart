import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/pages/buttons.dart';
import 'package:potato_fries/pages/debugging.dart';
import 'package:potato_fries/pages/lock_screen.dart';
import 'package:potato_fries/pages/misc.dart';
import 'package:potato_fries/pages/qs.dart';
import 'package:potato_fries/pages/status_bar.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:provider/provider.dart';
import 'package:spicy_components/spicy_components.dart';

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
          GestureDetector(
            onLongPress: provider.flag1 && provider.flag2 == 5
                ? provider.flag3
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DebuggingPage(),
                          ),
                        )
                    : () => provider.setFlag3()
                : null,
            child: IconButton(
              icon: provider.flag1 && provider.flag2 == 5 && provider.flag3
                  ? Icon(Icons.bug_report)
                  : Icon(Icons.menu),
              padding: EdgeInsets.all(0),
              onPressed: () => showNavigationSheet(
                context: context,
                provider: provider,
                items: pageInfo,
                onTap: (index) {
                  provider.pageIndex = index;
                  pageController.jumpToPage(provider.pageIndex);
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: provider.flag3 ? null : () => provider.flag2 += 1,
            onLongPress: provider.flag2 == 3
                ? () {
                    provider.setFlag4();
                    provider.flag2 = 0;
                  }
                : provider.flag3 ? null : () => provider.flag2 = 0,
            child: Builder(builder: (context) {
              var textColor;
              switch (provider.flag2) {
                case 1:
                  textColor = Colors.red;
                  break;
                case 2:
                  textColor = Colors.green;
                  break;
                case 3:
                  textColor = Colors.blue;
                  break;
              }
              return Text(
                pageInfo.keys.toList()[provider.pageIndex],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: textColor ??
                      Theme.of(context).iconTheme.color.withOpacity(0.7),
                ),
              );
            }),
          ),
        ],
        rightItems: [
          GestureDetector(
            onLongPress: () => provider.setFlag1(),
            child: IconButton(
              icon: Icon(
                provider.flag1
                    ? MdiIcons.accountGroup
                    : MdiIcons.accountGroupOutline,
              ),
              padding: EdgeInsets.all(0),
              onPressed: () {},
            ),
          ),
        ],
      ),
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
