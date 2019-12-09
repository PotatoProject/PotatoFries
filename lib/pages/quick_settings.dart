import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pagelayout/quick_settings_page_layout.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:provider/provider.dart';

class QuickSettings extends StatelessWidget {
  final title = 'Quick Settings';
  final icon = Icons.swap_vertical_circle;
  final ThemeBloc bloc;
  final int keyIndex;
  final QSDataProvider provider = QSDataProvider();

  QuickSettings({
    this.bloc,
    this.keyIndex,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> builtLayout =
        QuickSettingsPageLayout().build(context, keyIndex, provider: provider);
    List<GlobalKey> keys = builtLayout["keys"];
    List<Widget> children = builtLayout["body"];

    Future.delayed(
      Duration.zero,
      () async {
        if (keyIndex != null)
          Scrollable.ensureVisible(keys[keyIndex].currentContext);
      },
    );

    if (keyIndex != null) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: ChangeNotifierProvider.value(
          value: provider,
          child: Builder(
            builder: (context) => FriesPage(
              title: title,
              header: _header(context),
              children: children,
            ),
          ),
        ),
      );
    } else {
      return ChangeNotifierProvider.value(
        value: provider,
        child: Builder(
          builder: (context) => FriesPage(
            title: title,
            header: _header(context),
            children: children,
          ),
        ),
      );
    }
  }

  Widget _header(context) => Padding(
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
                              return Text(time.format(context), style: TextStyle(color: Colors.white));
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
                            var provider = Provider.of<QSDataProvider>(context);
                            String fwValsKey =
                                '${SettingType.SYSTEM}/qs_panel_bg_use_fw';
                            String wallKey =
                                '${SettingType.SYSTEM}/qs_panel_bg_use_wall';
                            String colorKey =
                                '${SettingType.SYSTEM}/qs_panel_bg_color';
                            String alphaKey =
                                '${SettingType.SYSTEM}/qs_panel_bg_alpha';
                            if (!(provider.data[fwValsKey] ?? true)) {
                              opacity = (provider.data[alphaKey] ?? 0) / 255;
                              if (provider.data[wallKey] ?? false) {
                                bgColor = Color(-12044500);
                              } else {
                                int colorData = provider.extraData[colorKey];
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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

    var provider = Provider.of<QSDataProvider>(context);
    String fwValsKey = '${SettingType.SYSTEM}/qs_panel_bg_use_fw';
    String wallKey = '${SettingType.SYSTEM}/qs_panel_bg_use_wall';
    String colorKey = '${SettingType.SYSTEM}/qs_panel_bg_color';
    if (!(provider.data[fwValsKey] ?? true)) {
      if (provider.data[wallKey] ?? false) {
        iconColor = Color(-12044500);
        tileColor = Colors.white;
        disabledIconColor = Colors.white;
      } else {
        int colorData = provider.extraData[colorKey];
        if (colorData != null) {
          iconColor = Color(colorData);
          tileColor = Colors.black;
          disabledIconColor = Colors.black87;
        }
      }
    }

    return InkWell(
      onTap: () => setState(() => enabled = !enabled),
      borderRadius: BorderRadius.circular(80),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor:
              enabled ? tileColor : disabledIconColor.withAlpha(30),
          child: Icon(
            widget.icon,
            color: enabled ? iconColor : disabledIconColor,
          ),
        ),
      ),
    );
  }
}
