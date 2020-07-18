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
  final int cooldown;
  final Color selectedColor;

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
    this.cooldown,
    this.selectedColor,
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
  bool coolingDown = false;

  @override
  Widget build(BuildContext context) {
    value = widget.getValue() ?? widget.defaultValue ?? widget.values[0];
    return AnimatedOpacity(
      opacity: coolingDown ? 0.5 : 1,
      duration: Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: coolingDown,
        child: SizeableListTile(
          title: widget.title,
          subtitle: Text(
            widget.values[value],
            style: TextStyle(
              color: Theme.of(context).textTheme.headline6.color.withAlpha(160),
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
                children: List.generate(
                  widget.values.length,
                  (index) {
                    bool selected = widget.values.values.toList()[index] ==
                        widget.values[value];
                    return SizeableListTile(
                      selectedColor: widget.selectedColor,
                      title: widget.values.values.toList()[index],
                      icon: selected ? Icon(Icons.check) : null,
                      selected: selected,
                      onTap: () => Navigator.pop(
                        context,
                        widget.values.keys.toList()[index],
                      ),
                    );
                  },
                ),
              ),
            );

            if (result != null) {
              widget.setValue(result);
              if (widget.cooldown != null) {
                setState(() => coolingDown = true);
                Future.delayed(Duration(milliseconds: widget.cooldown),
                    () => setState(() => coolingDown = false));
              }
            }
          },
        ),
      ),
    );
  }
}
