import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/ui/custom_icons.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/widgets/disco_spinner.dart';
import 'package:provider/provider.dart';

class AboutSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appInfo = context.watch<AppInfoProvider>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
              width: constraints.maxWidth,
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Column(
                children: <Widget>[
                  ShapedIcon.currentShape(
                    color: Color(0xFF8942CF),
                    iconSize: 96,
                    child: DiscoSpinner(
                      isSpinning: appInfo.discoEasterActive,
                      isEnabled: appInfo.discoEasterEnabled,
                      size: 96,
                      child: InkWell(
                        onLongPress: () => appInfo.toggleDisco(),
                        onTap: () => appInfo.debugFlagTap += 1,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/fries_foreground.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    appInfo.packageInfo.appName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${appInfo.packageInfo.version}+${appInfo.packageInfo.buildNumber}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(CustomIcons.potatoproject),
              title: Text("About PotatoProject"),
              onTap: () => Utils.launchUrl("https://potatoproject.co/"),
            ),
            ListTile(
              leading: Icon(MdiIcons.accountMultipleOutline),
              title: Text("About the team"),
              onTap: () => Utils.launchUrl("https://potatoproject.co/#team"),
            ),
            ListTile(
              leading: Icon(MdiIcons.github),
              title: Text("PotatoFries on GitHub"),
              onTap: () => Utils.launchUrl(
                  "https://github.com/PotatoProject/PotatoFries"),
            ),
          ],
        );
      },
    );
  }
}
