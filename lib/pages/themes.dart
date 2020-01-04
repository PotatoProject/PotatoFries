import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/themes.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/utils/obj_gen.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:potato_fries/widgets/settings_slider.dart';
import 'package:potato_fries/widgets/settings_switch.dart';
import 'package:provider/provider.dart';

class Themes extends StatelessWidget {
  final ThemesDataProvider provider = ThemesDataProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: _ThemesBody(),
    );
  }
}

class _ThemesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          title: Text('Themes'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        _header(context),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            shrinkWrap: true,
            itemCount: appData['themes'].keys.length,
            itemBuilder: (context, cindex) {
              List<Widget> children = [];
              String key = appData['themes'].keys.elementAt(cindex);
              Map<String, dynamic> workingMap = appData['themes'][key];
              children.add(Divider());
              children.add(
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Text(
                    key.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
              List<Widget> gen = List.generate(
                workingMap.keys.length,
                (index) {
                  var _key = workingMap.keys.elementAt(index);
                  var _value = workingMap[_key];
                  var provider = Provider.of<ThemesDataProvider>(context);
                  var appInfoProvider = Provider.of<AppInfoProvider>(context);
                  if (_value['version'] != null &&
                      !appInfoProvider.isCompatible(_value['version']))
                    return Container();
                  switch (_value['widget']) {
                    case WidgetType.SWITCH:
                      return SettingsSwitchTile(
                        title: _value['title'],
                        subtitle: _value['subtitle'],
                        icon: Icon(_value['icon']),
                        setValue: (val) {
                          provider.setValue(
                            settingsKey(
                              _key,
                              _value['setting_type'],
                            ),
                            val,
                          );
                        },
                        getValue: () {
                          return provider.getValue(
                            settingsKey(
                              _key,
                              _value['setting_type'],
                            ),
                          );
                        },
                      );
                    case WidgetType.SLIDER:
                      return SettingsSliderTile(
                        title: _value['title'],
                        min: (_value['widget_data']['min'] as int).toDouble(),
                        max: (_value['widget_data']['max'] as int).toDouble(),
                        percentage: _value['widget_data']['percentage'],
                        setValue: (val) {
                          provider.setValue(
                            settingsKey(
                              _key,
                              _value['setting_type'],
                            ),
                            val,
                          );
                        },
                        getValue: () {
                          return provider.getValue(
                            settingsKey(
                              _key,
                              _value['setting_type'],
                            ),
                          );
                        },
                      );
                    case WidgetType.COLOR_PICKER:
                      return ColorPickerTile(
                        title: _value['title'],
                        subtitle: _value['subtitle'],
                        onApply: (Color color) {
                          provider.setValue(
                            settingsKey(
                              _key,
                              _value['setting_type'],
                            ),
                            color.value,
                          );
                        },
                        lightnessMin: _value['widget_data']['lightness_min'],
                        lightnessMax: _value['widget_data']['lightness_max'],
                        getColor: () {
                          return Color(
                            provider.getValue(
                                  settingsKey(
                                    _key,
                                    _value['setting_type'],
                                  ),
                                ) ??
                                0,
                          );
                        },
                        defaultColor: Colors.transparent,
                      );
                    case WidgetType.CUSTOM:
                      return ObjectGen.fromString(_value['setting_type']);
                    default:
                      return ListTile(
                        title: Text(_value['title'] ?? 'Bruh.'),
                        subtitle: Text('bro wat'),
                      );
                  }
                },
              );
              children.addAll(gen);
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _header(context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 4.2,
          width: MediaQuery.of(context).size.width - 24,
          child: Card(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 6),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height / 32),
                      ),
                      color: Theme.of(context).cardColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Opacity(
                            opacity: 0.65,
                            child: Text('Search settings'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 4.0, right: 4.0),
                            child: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              backgroundColor: Theme.of(context).accentColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                _pref(context, Icons.wifi, Colors.blue),
                _pref(context, Icons.devices_other, Colors.green),
                _pref(context, Icons.apps, Colors.orange),
              ],
            ),
          ),
        ),
      );

  Widget _pref(BuildContext context, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          icon,
          color: Colors.white,
        ),
        backgroundColor: color,
      ),
      title: Container(
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).textTheme.body1.color.withOpacity(0.2),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 8),
        child: Container(
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).textTheme.body1.color.withOpacity(0.15),
          ),
        ),
      ),
    );
  }
}
