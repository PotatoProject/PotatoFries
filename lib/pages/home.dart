import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/pages/licenses.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/badged_icon.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/pages/base_page.dart';
import 'package:potato_fries/pages/debugging.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/widgets/about_sheet.dart';
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

    if (provider.debugEnabled) _pages.add(DebuggingPage());

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
            leading: IconButton(
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
            title: Text(
              pages[provider.pageIndex].title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            trailing: PopupMenuButton(
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
                  child: Text("About Fries"),
                  value: "aboutfries",
                  icon: Icon(CustomIcons.fries),
                ),
                PopupMenuItemWithIcon(
                  child: Text("Open source licenses"),
                  value: "aboutoss",
                  icon: Icon(MdiIcons.license),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case "backup":
                    break;
                  case "restore":
                    break;
                  case "aboutfries":
                    Utils.showBottomSheet(
                      context: context,
                      builder: (context) => AboutSheet(),
                    );
                    break;
                  case "aboutoss":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LicensesPage(),
                        ));
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
