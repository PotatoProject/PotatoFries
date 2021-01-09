import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:provider/provider.dart';

class SettingsSwitchTile extends StatefulWidget {
  final SettingPreference pref;
  final bool enabled;

  SettingsSwitchTile({
    @required this.pref,
    this.enabled = true,
  }) : assert(pref != null);

  @override
  _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<PageProvider>();
    final pref = widget.pref;
    final options = widget.pref.options as SwitchOptions;
    final value = _provider.getValue(pref.setting) ?? options.defaultValue;

    return SizeableListTile(
      title: pref.title,
      icon: SmartIcon(pref.icon),
      subtitle: pref.description == null ? null : Text(pref.description),
      trailing: SettingsSwitch(
        enabled: widget.enabled,
        setValue: (v) => _provider.setValue(pref.setting, v),
        value: value,
      ),
      onTap: () => _provider.setValue(pref.setting, !value),
    );
  }
}

class SettingsSwitch extends StatelessWidget {
  final bool enabled;
  final Function setValue;
  final bool value;
  final Color activeColor;

  SettingsSwitch({
    this.enabled = true,
    @required this.setValue,
    @required this.value,
    this.activeColor,
  })  : assert(setValue != null),
        assert(value != null);

  @override
  Widget build(BuildContext context) {
    final activeColor = this.activeColor ?? Theme.of(context).accentColor;
    return Switch(
      activeColor: activeColor,
      value: value,
      onChanged: enabled ? (b) => setValue(b) : null,
    );
  }
}
