import 'package:flutter/material.dart';
import 'package:potato_fries/ui/cross_fade.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class SettingsDropdownTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String footer;
  final Widget icon;
  final bool enabled;
  final Function setValue;
  final Function getValue;
  final Map values;

  SettingsDropdownTile({
    @required this.title,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    @required this.setValue,
    @required this.getValue,
    this.values,
  })  : assert(title != null),
        assert(setValue != null),
        assert(getValue != null),
        assert(values != null);

  @override
  _SettingsDropdownTileState createState() => _SettingsDropdownTileState();
}

class _SettingsDropdownTileState extends State<SettingsDropdownTile> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    value = widget.getValue();
    return SizeableListTile(
      title: Container(
        width: double.maxFinite,
        child: DropdownButton(
          value: value ?? widget.values[0],
          items: widget.values.keys
              .map(
                (k) => DropdownMenuItem(
                  value: k,
                  child: Text(widget.values[k]),
                ),
              )
              .toList(),
          onChanged: (_value) {
            setState(() => value = _value);
            widget.setValue(value);
          },
        ),
      ),
      icon: widget.icon,
      subtitle: Builder(
        builder: (context) {
          if (widget.subtitle == null && widget.title == null) return null;
          if (widget.subtitle == null)
            return Text(widget.title, style: TextStyle(color: Colors.white));
          else
            return CrossFadePeriodic(
              firstChild: Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
              secondChild: Text(widget.subtitle),
            );
        },
      ),
      footer: widget.footer,
    );
  }
}

class SettingsDropDown extends StatelessWidget {
  final bool enabled;
  final Function setValue;
  final bool value;

  SettingsDropDown({
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
