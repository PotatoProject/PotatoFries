import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/smart_icon.dart';
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
  final bool useTopPadding;

  PageParser({@required this.dataKey, this.useTopPadding = true});

  @override
  Widget build(BuildContext context) => Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(
            top: useTopPadding ? MediaQuery.of(context).padding.top : 8,
            bottom: 8,
          ),
          shrinkWrap: true,
          itemCount: appData[dataKey].keys.length,
          itemBuilder: (context, cindex) {
            List<Widget> children = [];
            String key = appData[dataKey].keys.elementAt(cindex);
            Map<String, dynamic> workingMap = appData[dataKey][key];
            var provider = Provider.of<PageProvider>(context);
            var appInfoProvider = Provider.of<AppInfoProvider>(context);

            bool emptySection = true;
            for (String _key in workingMap.keys) {
              var _value = workingMap[_key];
              if ((_value['version'] == null ||
                      appInfoProvider.isCompatible(_value['version'],
                          max: _value['version_max'])) &&
                  (appInfoProvider.isCompatCheckDisabled() ||
                      _value['compat'] == null ||
                      (provider.getValue(settingsKey(
                            _key + '~COMPAT',
                            _value['setting_type'],
                          )) ??
                          false))) {
                emptySection = false;
              }
            }
            if (emptySection) return Container();
            children.add(
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  key.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ),
              ),
            );
            List<Widget> gen = List.generate(
              workingMap.keys.length,
              (index) {
                var _key = workingMap.keys.elementAt(index);
                var _value = workingMap[_key];
                bool enabled = true;
                if (_value['dependencies'] != null) {
                  for (Map m in _value['dependencies']) {
                    var sKey = settingsKey(m['name'], m['setting_type']);
                    var sVal = provider.getValue(sKey);
                    if (sVal != null) {
                      enabled = enabled &&
                          (m['values'] != null
                              ? (m['values'] as List).contains(sVal)
                              : sVal == m['value']);
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
                        if ((_value['version'] != null &&
                                !appInfoProvider.isCompatible(_value['version'],
                                    max: _value['version_max'])) ||
                            (!appInfoProvider.isCompatCheckDisabled() &&
                                _value['compat'] != null &&
                                !(provider.getValue(settingsKey(
                                      _key + '~COMPAT',
                                      _value['setting_type'],
                                    )) ??
                                    false))) {
                          return Container();
                        }
                        switch (_value['widget']) {
                          case WidgetType.SWITCH:
                            return SettingsSwitchTile(
                              title: _value['title'],
                              subtitle: _value['subtitle'],
                              icon: SmartIcon(_value['icon']),
                              cooldown: _value['cooldown'] as int,
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
                                var value = provider.getValue(
                                  settingsKey(
                                    _key,
                                    _value['setting_type'],
                                  ),
                                );
                                if (value == null) return value;
                                return Color(value);
                              },
                              defaultColor: _value.containsKey('widget_data') &&
                                      _value['widget_data']
                                          .containsKey('default')
                                  ? (_value['widget_data']['default'] as Color)
                                  : Colors.transparent,
                              showUnsetPreview: _value['widget_data']
                                      ['unset_preview'] ??
                                  false,
                            );
                          case WidgetType.CUSTOM:
                            return ObjectGen.fromString(_value['setting_type']);
                          case WidgetType.DROPDOWN:
                            return SettingsDropdownTile(
                              title: _value['title'],
                              subtitle: _value['subtitle'],
                              icon: SmartIcon(_value['icon']),
                              cooldown: _value['cooldown'] as int,
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
                              values: _value['widget_data']['values'],
                              defaultValue: _value.containsKey('widget_data') &&
                                      _value['widget_data']
                                          .containsKey('default')
                                  ? (_value['widget_data']['default'])
                                  : null,
                            );
                          case WidgetType.ACTIVITY:
                            return ActivityTile(
                              title: _value['title'],
                              subtitle: _value['subtitle'],
                              icon: SmartIcon(_value['icon']),
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
