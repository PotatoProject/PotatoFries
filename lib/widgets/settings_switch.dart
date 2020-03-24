import 'package:flutter/material.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class SettingsSwitchTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String footer;
  final Widget icon;
  final bool enabled;
  final Function setValue;
  final Function getValue;
  final bool defaultValue;

  SettingsSwitchTile({
    @required this.title,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    @required this.setValue,
    @required this.getValue,
    this.defaultValue = false,
  })  : assert(title != null),
        assert(setValue != null),
        assert(getValue != null);

  @override
  _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    value = widget.getValue() ?? widget.defaultValue ?? false;
    return SizeableListTile(
      title: widget.title,
      icon: widget.icon,
      subtitle: widget.subtitle == null ? null : Text(widget.subtitle),
      footer: widget.footer,
      trailing: SettingsSwitch(
        enabled: widget.enabled,
        setValue: (v) {
          setState(() => value = v);
          widget.setValue(value);
        },
        value: value,
      ),
      onTap: () {
        setState(() => value = !value);
        widget.setValue(value);
      },
    );
  }
}

class SettingsSwitch extends StatelessWidget {
  final bool enabled;
  final Function setValue;
  final bool value;

  SettingsSwitch({
    this.enabled = true,
    @required this.setValue,
    @required this.value,
  })  : assert(setValue != null),
        assert(value != null);

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Theme.of(context).accentColor,
      value: value,
      onChanged: enabled ? (b) => setValue(b) : null,
    );
  }
}
