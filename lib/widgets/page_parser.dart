import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/data/app.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/smart_icon.dart';
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
            provider.warmupPage(dataKey);

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
            for (Preference _pref in workingMap) {
              bool enabled = true;
              bool skip = false;

              if (_pref.dependencies.isNotEmpty) {
                for (Dependency d in _pref.dependencies) {
                  if (d is SettingDependency) {
                    var sVal = provider.getValue(d.key);
                    if (sVal != null) {
                      enabled = enabled && (sVal == d.value);
                    }
                  } else if (d is PropDependency) {
                    var pVal = provider.getValue(d.key);
                    if (d.value != pVal) skip = true;
                  }
                }
              }

              if (!appInfoProvider.isVersionCheckDisabled() &&
                  !_pref.versionConstraint
                      .isConstrained(appInfoProvider.hostVersion)) {
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
                        if (_pref is SettingPreference) {
                          switch (_pref.setting.valueType) {
                            case SettingValueType.STRING:
                              return SettingsDropdownTile(pref: _pref);
                            case SettingValueType.BOOLEAN:
                              return SettingsSwitchTile(pref: _pref);
                            case SettingValueType.INT:
                              return SettingsSliderTile(pref: _pref);
                          }
                        }
                        if (_pref is ActivityPreference) {
                          return ActivityTile(
                            title: _pref.title,
                            subtitle: _pref.description,
                            icon: SmartIcon(_pref.icon),
                            cls: _pref.cls,
                            pkg: _pref.pkg,
                          );
                        }
                        if (_pref is CustomPreference) {
                          return ObjectGen.fromString(_pref.id);
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
