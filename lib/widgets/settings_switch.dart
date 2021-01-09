import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:provider/provider.dart';

class SettingsSwitchTile extends StatefulWidget {
  final SettingPreference pref;
  final bool enabled;
  final int cooldown;

  SettingsSwitchTile({
    @required this.pref,
    this.enabled = true,
    this.cooldown,
  }) : assert(pref != null);

  @override
  _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  bool coolingDown = false;

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<PageProvider>();
    final pref = widget.pref;
    final options = widget.pref.options as SwitchOptions;
    final value = _provider.getValue(pref.setting) ?? options.defaultValue;

    return AnimatedOpacity(
      opacity: coolingDown ? 0.5 : 1.0,
      duration: Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: coolingDown,
        child: SizeableListTile(
          title: pref.title,
          icon: SmartIcon(pref.icon),
          subtitle: pref.description == null ? null : Text(pref.description),
          trailing: SettingsSwitch(
            enabled: widget.enabled,
            setValue: (v) => _setValue(_provider, pref.setting, v),
            value: value,
          ),
          onTap: () => _setValue(_provider, pref.setting, !value),
        ),
      ),
    );
  }

  void _setValue(PageProvider provider, SettingKey setting, bool newValue) {
    provider.setValue(setting, newValue);
    if (widget.cooldown != null) {
      setState(() => coolingDown = true);
      Future.delayed(Duration(milliseconds: widget.cooldown),
          () => setState(() => coolingDown = false));
    }
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
