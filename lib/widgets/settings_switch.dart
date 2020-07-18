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
  final int cooldown;

  SettingsSwitchTile({
    @required this.title,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    @required this.setValue,
    @required this.getValue,
    this.defaultValue,
    this.cooldown,
  })  : assert(title != null),
        assert(setValue != null),
        assert(getValue != null);

  @override
  _SettingsSwitchTileState createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  bool value = false;
  bool coolingDown = false;

  @override
  Widget build(BuildContext context) {
    value = widget.getValue() ?? widget.defaultValue ?? false;
    return AnimatedOpacity(
      opacity: coolingDown ? 0.5 : 1.0,
      duration: Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: coolingDown,
        child: SizeableListTile(
          title: widget.title,
          icon: widget.icon,
          subtitle: widget.subtitle == null ? null : Text(widget.subtitle),
          footer: widget.footer,
          trailing: SettingsSwitch(
            enabled: widget.enabled,
            setValue: (v) {
              setState(() => value = v);
              widget.setValue(value);
              if (widget.cooldown != null) {
                setState(() => coolingDown = true);
                Future.delayed(Duration(milliseconds: widget.cooldown),
                    () => setState(() => coolingDown = false));
              }
            },
            value: value,
          ),
          onTap: () {
            setState(() => value = !value);
            widget.setValue(value);
            if (widget.cooldown != null) {
              setState(() => coolingDown = true);
              Future.delayed(Duration(milliseconds: widget.cooldown),
                  () => setState(() => coolingDown = false));
            }
          },
        ),
      ),
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
