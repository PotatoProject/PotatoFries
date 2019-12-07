import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/bloc/theme_bloc.dart';
import 'package:potato_fries/pages/fries_page.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:potato_fries/widgets/settings_slider.dart';
import 'package:potato_fries/widgets/settings_switch.dart';
import 'package:provider/provider.dart';

class QuickSettings extends StatelessWidget {
  final title = 'Quick Settings';
  final icon = Icons.swap_vertical_circle;
  final ThemeBloc bloc;

  QuickSettings({this.bloc});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: QSDataProvider(),
      child: Builder(
        builder: (context) => FriesPage(
          title: title,
          header: _header(context),
          children: <Widget>[
            SettingsSwitch(
              icon: Icon(Icons.settings_backup_restore),
              setting: 'qs_panel_bg_use_fw',
              type: SettingType.SYSTEM,
              provider: Provider.of<QSDataProvider>(context),
              title: 'Use framework values for QS',
              subtitle: 'Disable QS colors and use framework values',
            ),
            SettingsSwitch(
              icon: Icon(Icons.colorize),
              setting: 'qs_panel_bg_use_wall',
              type: SettingType.SYSTEM,
              provider: Provider.of<QSDataProvider>(context),
              title: 'Use wallpaper colors',
              subtitle: 'Dynamically choose colors from the wallpaper',
            ),
            SettingsSlider(
              setting: 'qs_panel_bg_alpha',
              type: SettingType.SYSTEM,
              min: 100,
              max: 255,
              title: 'QS Panel Opacity',
              provider: Provider.of<QSDataProvider>(context),
              subtitle: 'Set Alpha for QS background',
            ),
          ],
        ),
      ),
    );
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
                  height: MediaQuery.of(context).size.height / 6,
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
                          Text('12:00'),
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
                            Color QSColor = Colors.red;
                            String fwValsKey =
                                '${SettingType.SYSTEM}/qs_panel_bg_use_fw';
                            print(Provider.of<QSDataProvider>(context).data);
                            if (Provider.of<QSDataProvider>(context)
                                    .data[fwValsKey] ??
                                false) {
                              QSColor = Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Colors.white;
                            }
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              color: QSColor,
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
                        child: Text('No notifications'.toUpperCase()),
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

  _QSTile({this.icon, this.enabled = false});

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
    return GestureDetector(
      onTap: () => setState(() => enabled = !enabled),
      child: CircleAvatar(
        backgroundColor: enabled ? Colors.white : Colors.white30,
        child: Icon(
          widget.icon,
          color: enabled ? Theme.of(context).accentColor : Colors.white,
        ),
      ),
    );
  }
}
