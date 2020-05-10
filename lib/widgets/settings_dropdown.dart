import 'package:flutter/material.dart';
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
      title: widget.title,
      subtitle: Text(
        widget.values[value],
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6.color
              .withAlpha(160)
        ),
      ),
      icon: widget.icon,
      onTap: () async {
        var result = await showModalBottomSheet(
          context: context,
          isScrollControlled: false,
          builder: (context) => ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: List.generate(widget.values.length, (index) {
              bool selected = widget.values.values.toList()[index] == widget.values[value];
              return SizeableListTile(
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
    );
  }
}