import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/badged_icon.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/pages/debugging.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/widgets/popup_menu_widgets.dart';
import 'package:provider/provider.dart';

class FriesHome extends StatefulWidget {
  @override
  _FriesHomeState createState() => _FriesHomeState();
}

class _FriesHomeState extends State<FriesHome> {
  @override
  void initState() {
    context.read<PageProvider>().warmupPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AppInfoProvider>();

    List<BasePage> _pages = List.from(pages);
    if (!provider.audioFxSupported)
      _pages.removeWhere((element) => element.providerKey == 'audiofx');

    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: _pages[provider.pageIndex],
      ),
      bottomNavigationBar: _BottomNavBar(pages: _pages),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final List<BasePage> pages;

  _BottomNavBar({
    @required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AppInfoProvider>();
    return Material(
      color: Theme.of(context).canvasColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1.5,
            thickness: 1.5,
          ),
          ListTile(
            leading: GestureDetector(
              onLongPress: (provider.flag1 && provider.flag2 == 5) || kDebugMode
                  ? () {
                      if (provider.flag3 || kDebugMode) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DebuggingPage(),
                          ),
                        );
                      } else {
                        provider.setFlag3();
                      }
                    }
                  : null,
              child: IconButton(
                icon: BadgedIcon(
                  icon: Icon(Icons.menu),
                  badgeIcon:
                      provider.debugEnabled ? Icon(Icons.bug_report) : null,
                ),
                padding: EdgeInsets.zero,
                onPressed: () => Utils.showNavigationSheet(
                  context: context,
                  pages: pages,
                  onTap: (index) {
                    provider.pageIndex = index;
                  },
                ),
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            title: GestureDetector(
              onTap: !provider.debugPhase3 ? () => provider.flag2 += 1 : null,
              onLongPress: provider.flag2 == 3
                  ? () {
                      provider.setFlag4();
                      provider.flag2 = 0;
                    }
                  : !provider.debugPhase3
                      ? () => provider.flag2 = 0
                      : null,
              child: Builder(
                builder: (context) {
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
                    pages[provider.pageIndex].title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor ?? Theme.of(context).iconTheme.color,
                    ),
                  );
                },
              ),
            ),
            trailing: GestureDetector(
              onLongPress: () => provider.setFlag1(),
              child: PopupMenuButton(
                icon: Icon(
                  Icons.adaptive.more,
                  color: Theme.of(context).iconTheme.color,
                ),
                itemBuilder: (context) => <PopupMenuEntry>[
                  PopupMenuHeader(text: "Backup & restore"),
                  PopupMenuItemWithIcon(
                    child: Text("Backup"),
                    value: "backup",
                    icon: Icon(MdiIcons.backupRestore),
                    enabled: false,
                  ),
                  PopupMenuItemWithIcon(
                    child: Text("Restore"),
                    value: "restore",
                    icon: Icon(MdiIcons.fileRestoreOutline),
                    enabled: false,
                  ),
                  PopupMenuHeader(text: "About"),
                  PopupMenuItemWithIcon(
                    child: Text("About the team"),
                    value: "aboutteam",
                    icon: Icon(MdiIcons.accountGroupOutline),
                  ),
                  PopupMenuItemWithIcon(
                    child: Text("About PotatoProject"),
                    value: "aboutpotato",
                    icon: Icon(CustomIcons.potatoproject),
                  ),
                  PopupMenuItemWithIcon(
                    child: Text("About Fries"),
                    value: "aboutfries",
                    icon: Icon(CustomIcons.fries),
                  ),
                ],
                onSelected: (value) async {
                  switch (value) {
                    case "backup":
                      break;
                    case "restore":
                      break;
                    case "aboutteam":
                      Utils.launchUrl(
                        'https://potatoproject.co/#team',
                        context: context,
                      );
                      break;
                    case "aboutpotato":
                      Utils.launchUrl(
                        'https://potatoproject.co',
                        context: context,
                      );
                      break;
                    case "aboutfries":
                      break;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
