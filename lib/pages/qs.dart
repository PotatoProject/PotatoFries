import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:potato_fries/ui/shaped_icon.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/widgets/page_parser.dart';
import 'package:provider/provider.dart';

class QuickSettings extends StatelessWidget {
  final QsDataProvider provider = QsDataProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: _QuickSettingsBody(),
    );
  }
}

class _QuickSettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Quick Settings'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        _header(context),
        PageParser(dataKey: 'qs'),
      ],
    );
  }

  Widget _header(context) {
    String fwValsKey = settingsKey('qs_panel_bg_use_fw', SettingType.SYSTEM);
    String wallKey = settingsKey('qs_panel_bg_use_wall', SettingType.SYSTEM);
    String colorKey = settingsKey('qs_panel_bg_color', SettingType.SYSTEM);
    String alphaKey = settingsKey('qs_panel_bg_alpha', SettingType.SYSTEM);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3.4,
        width: MediaQuery.of(context).size.width - 24,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Image.asset(
                  'assets/wallpaper.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Colors.black38),
                height: MediaQuery.of(context).size.height / 3.4,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.10, 0.95],
                  ),
                ),
                height: MediaQuery.of(context).size.height / 3.5,
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 6),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Builder(
                          builder: (context) {
                            TimeOfDay time = TimeOfDay.now();
                            return Text(time.format(context),
                                style: TextStyle(color: Colors.white));
                          },
                        ),
                        Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Builder(
                        builder: (context) {
                          Color bgColor =
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.black
                                  : Colors.white;
                          double opacity = 1.0;
                          var provider = Provider.of<QsDataProvider>(context);
                          if (!(provider.getValue(fwValsKey) ?? true)) {
                            opacity = (provider.getValue(alphaKey) ?? 0) / 255;
                            if (provider.getValue(wallKey) ?? false) {
                              bgColor = Color(-12044500);
                            } else {
                              int colorData = provider.getValue(colorKey);
                              if (colorData != null) {
                                bgColor = Color(colorData);
                              }
                            }
                          }

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: bgColor.withOpacity(opacity),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _QSTile(icon: Icons.wifi, enabled: true),
                                _QSTile(icon: Icons.bluetooth),
                                _QSTile(icon: Icons.swap_vert, enabled: true),
                                _QSTile(icon: Icons.do_not_disturb_on),
                                _QSTile(icon: Icons.highlight),
                                _QSTile(
                                  icon: Icons.screen_rotation,
                                  enabled: true,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'No notifications'.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QSTile extends StatefulWidget {
  final IconData icon;
  final bool enabled;

  _QSTile({
    this.icon,
    this.enabled = false,
  });

  @override
  __QSTileState createState() => __QSTileState();
}

class __QSTileState extends State<_QSTile> {
  bool enabled;

  @override
  void initState() {
    enabled = widget.enabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color tileColor = Theme.of(context).accentColor;

    Color iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;

    Color disabledIconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.black87;

    var provider = Provider.of<QsDataProvider>(context);
    String fwValsKey = settingsKey('qs_panel_bg_use_fw', SettingType.SYSTEM);
    String wallKey = settingsKey('qs_panel_bg_use_wall', SettingType.SYSTEM);
    String colorKey = settingsKey('qs_panel_bg_color', SettingType.SYSTEM);
    if (!(provider.getValue(fwValsKey) ?? true)) {
      if (provider.getValue(wallKey) ?? false) {
        iconColor = Color(-12044500);
        tileColor = Colors.white;
        disabledIconColor = Colors.white;
      } else {
        int colorData = provider.getValue(colorKey);
        if (colorData != null) {
          iconColor = Color(colorData);
          tileColor = Colors.white;
          disabledIconColor = Colors.white70;
        }
      }
    }

    return GestureDetector(
      onTap: () => setState(() => enabled = !enabled),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ShapedIcon(
          type: Provider.of<AppInfoProvider>(context).getIconShapeIndex(),
          color: enabled ? tileColor : disabledIconColor.withAlpha(30),
          child: Icon(
            widget.icon,
            color: enabled ? iconColor : disabledIconColor,
          ),
          iconSize: 40,
        ),
      ),
    );
  }
}
