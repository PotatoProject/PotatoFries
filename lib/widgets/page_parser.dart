import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/buttons.dart';
import 'package:potato_fries/provider/lock_screen.dart';
import 'package:potato_fries/provider/misc.dart';
import 'package:potato_fries/provider/qs.dart';
import 'package:potato_fries/provider/status_bar.dart';
import 'package:potato_fries/provider/themes.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/utils/obj_gen.dart';
import 'package:potato_fries/widgets/activity.dart';
import 'package:potato_fries/widgets/color_picker.dart';
import 'package:potato_fries/widgets/directory.dart';
import 'package:potato_fries/widgets/settings_dropdown.dart';
import 'package:potato_fries/widgets/settings_slider.dart';
import 'package:potato_fries/widgets/settings_switch.dart';
import 'package:provider/provider.dart';

class PageParser extends StatelessWidget {
  final String dataKey;

  PageParser({@required this.dataKey});

  @override
  Widget build(BuildContext context) => Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 0.0,
          ),
          shrinkWrap: true,
          itemCount: appData[dataKey].keys.length,
          itemBuilder: (context, cindex) {
            List<Widget> children = [];
            String key = appData[dataKey].keys.elementAt(cindex);
            Map<String, dynamic> workingMap = appData[dataKey][key];
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
                var provider;
                switch (dataKey) {
                  case 'buttons_and_gestures':
                    provider = Provider.of<ButtonsDataProvider>(context);
                    break;
                  case 'lock_screen':
                    provider = Provider.of<LockScreenDataProvider>(context);
                    break;
                  case 'qs':
                    provider = Provider.of<QsDataProvider>(context);
                    break;
                  case 'status_bar':
                    provider = Provider.of<StatusBarDataProvider>(context);
                    break;
                  case 'themes':
                    provider = Provider.of<ThemesDataProvider>(context);
                    break;
                  case 'misc':
                    provider = Provider.of<MiscDataProvider>(context);
                    break;
                }
                var appInfoProvider = Provider.of<AppInfoProvider>(context);
                bool enabled = true;
                if (_value['dependencies'] != null) {
                  for (Map m in _value['dependencies']) {
                    var sKey = settingsKey(m['name'], m['setting_type']);
                    var sVal = provider.getValue(sKey);
                    if (sVal != null) {
                      enabled = enabled && sVal == m['value'];
                    }
                  }
                }
                return AnimatedOpacity(
                  opacity: enabled ? 1.0 : 0.5,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: IgnorePointer(
                    ignoring: !enabled,
                    child: Builder(
                      builder: (context) {
                        if (_value['version'] != null &&
                            !appInfoProvider.isCompatible(
                              _value['version'],
                              max: _value['version_max'],
                            )) return Container();
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
                              defaultValue: _value.containsKey('widget_data') &&
                                      _value['widget_data']
                                          .containsKey('default')
                                  ? (_value['widget_data']['default'] as bool)
                                  : false,
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
                              min: (_value['widget_data']['min'] as int)
                                      ?.toDouble() ??
                                  0.0,
                              max: (_value['widget_data']['max'] as int)
                                      ?.toDouble() ??
                                  0.0,
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
                              defaultValue: _value.containsKey('widget_data') &&
                                      _value['widget_data']
                                          .containsKey('default')
                                  ? (_value['widget_data']['default'] as int)
                                          ?.toDouble() ??
                                      0.0
                                  : (_value['widget_data']['min'] as int)
                                          ?.toDouble() ??
                                      0.0,
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
                              lightnessMin: _value['widget_data']
                                  ['lightness_min'],
                              lightnessMax: _value['widget_data']
                                  ['lightness_max'],
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
                              defaultColor: _value.containsKey('widget_data') &&
                                      _value['widget_data']
                                          .containsKey('default')
                                  ? (_value['widget_data']['default'] as Color)
                                  : Colors.transparent,
                            );
                          case WidgetType.CUSTOM:
                            return ObjectGen.fromString(_value['setting_type']);
                          case WidgetType.DROPDOWN:
                            return SettingsDropdownTile(
                              title: _value['title'],
                              subtitle: _value['subtitle'],
                              icon: Icon(_value['icon']),
                              setValue: (val) {
                                print('running set ' + val);
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
                              values: _value['widget_data']['values'],
                            );
                          case WidgetType.ACTIVITY:
                            return ActivityTile(
                              title: _value['title'],
                              subtitle: _value['subtitle'],
                              icon: Icon(_value['icon']),
                              cls: _value['class'],
                              pkg: _value['package'],
                            );
                          default:
                            return ListTile(
                              title: Text(_value['title'] ?? 'Bruh.'),
                              subtitle: Text('bro wat'),
                            );
                        }
                      },
                    ),
                  ),
                );
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
      );
}
