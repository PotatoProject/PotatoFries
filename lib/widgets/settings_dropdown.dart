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
  final String defaultValue;

  SettingsDropdownTile({
    @required this.title,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    @required this.setValue,
    @required this.getValue,
    this.values,
    this.defaultValue,
  })  : assert(title != null),
        assert(setValue != null),
        assert(getValue != null),
        assert(values != null),
        assert(defaultValue == null ||
            (defaultValue != null && values.containsKey(defaultValue)));

  @override
  _SettingsDropdownTileState createState() => _SettingsDropdownTileState();
}

class _SettingsDropdownTileState extends State<SettingsDropdownTile> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    value = widget.getValue() ?? widget.defaultValue ?? widget.values[0];
    return SizeableListTile(
      height: 64,
      title: widget.title,
      subtitle: widget.subtitle != null
          ? Text(widget.subtitle)
          : null,
      icon: widget.icon,
      trailing: Text(
        widget.values[value],
        style: TextStyle(
          color: Theme.of(context).textTheme.title.color
              .withAlpha(160)
        ),
      ),
      onTap: () async {
        var result = await showModalBottomSheet(
          context: context,
          isScrollControlled: false,
          builder: (context) => ListView(
            shrinkWrap: true,
            children: List.generate(widget.values.length, (index) {
              bool selected = widget.values.values.toList()[index] == widget.values[value];
              return SizeableListTile(
                height: 56,
                title: widget.values.values.toList()[index],
                icon: selected
                    ? Icon(Icons.check)
                    : null,
                selected: selected,
                onTap: () => Navigator.pop(context, widget.values.keys.toList()[index]),
              );
            }),
          )
        );

        if(result != null) {
          widget.setValue(result);
        }
      },
      /*title: Container(
        width: double.maxFinite,
        child: DropdownButton(
          value: value,
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
            return Text(widget.title,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black));
          else
            return CrossFadePeriodic(
              firstChild: Text(
                widget.title,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black),
              ),
              secondChild: Text(widget.subtitle),
            );
        },
      ),
      footer: widget.footer,*/
    );
  }
}