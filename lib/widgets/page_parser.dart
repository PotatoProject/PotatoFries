import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:potato_fries/utils/methods.dart';
import 'package:potato_fries/utils/obj_gen.dart';
import 'package:potato_fries/widgets/activity.dart';
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
            List<Preference> workingMap = appData[dataKey][key];
            var provider = Provider.of<PageProvider>(context);
            var appInfoProvider = Provider.of<AppInfoProvider>(context);

            if (workingMap.isEmpty) return Container();

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

            List<Widget> gen = [];
            for (Preference _value in workingMap) {
              bool enabled = true;
              bool skip = false;
              if (_value.dependencies.isNotEmpty) {
                for (Dependency d in _value.dependencies) {
                  if (d is SettingDependency) {
                    var sKey = settingsKey(d.name, d.type);
                    var sVal = provider.getValue(sKey);
                    if (sVal != null) {
                      enabled = sVal == d.value;
                    }
                  } else if (d is PropDependency) {
                    var pVal =
                        provider.getValue("SYSTEM:" + d.name + "~COMPAT");
                    if (d.value != pVal) skip = true;
                  }
                }
              }

              if (_value.minVersion != null &&
                  !appInfoProvider.isCompatible(_value.minVersion)) {
                skip = true;
              }

              if (skip) continue;

              gen.add(
                AnimatedOpacity(
                  opacity: enabled ? 1.0 : 0.5,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: IgnorePointer(
                    ignoring: !enabled,
                    child: Builder(
                      builder: (context) {
                        if (_value is SettingPreference) {
                          switch (_value.valueType) {
                            case SettingValueType.STRING:
                              final options = _value.options as DropdownOptions;
                              return SettingsDropdownTile(
                                title: _value.title,
                                subtitle: _value.description,
                                icon: SmartIcon(_value.icon),
                                setValue: (val) {
                                  provider.setValue(
                                    settingsKey(
                                      _value.setting,
                                      _value.type,
                                    ),
                                    val,
                                  );
                                },
                                getValue: () {
                                  return provider.getValue(
                                    settingsKey(
                                      _value.setting,
                                      _value.type,
                                    ),
                                  );
                                },
                                values: options.values,
                                defaultValue: options.defaultValue,
                              );
                            case SettingValueType.BOOLEAN:
                              final options = _value.options as SwitchOptions;
                              return SettingsSwitchTile(
                                title: _value.title,
                                subtitle: _value.description,
                                icon: SmartIcon(_value.icon),
                                setValue: (val) {
                                  provider.setValue(
                                    settingsKey(
                                      _value.setting,
                                      _value.type,
                                    ),
                                    val,
                                  );
                                },
                                defaultValue: options.defaultValue,
                                getValue: () {
                                  return provider.getValue(
                                    settingsKey(
                                      _value.setting,
                                      _value.type,
                                    ),
                                  );
                                },
                              );
                            case SettingValueType.INT:
                              final options = _value.options as SliderOptions;
                              return SettingsSliderTile(
                                title: _value.title,
                                min: options.min.toDouble(),
                                max: options.max.toDouble(),
                                percentage: options.percentage,
                                setValue: (val) {
                                  provider.setValue(
                                    settingsKey(
                                      _value.setting,
                                      _value.type,
                                    ),
                                    val,
                                  );
                                },
                                defaultValue: options.defaultValue.toDouble(),
                                getValue: () {
                                  return provider.getValue(
                                    settingsKey(
                                      _value.setting,
                                      _value.type,
                                    ),
                                  );
                                },
                              );
                          }
                        }
                        if (_value is ActivityPreference) {
                          return ActivityTile(
                            title: _value.title,
                            subtitle: _value.description,
                            icon: SmartIcon(_value.icon),
                            cls: _value.cls,
                            pkg: _value.pkg,
                          );
                        }
                        if (_value is CustomPreference) {
                          return ObjectGen.fromString(_value.id);
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              );
            }
            if (gen.isEmpty) return Container();

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
