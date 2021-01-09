import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:provider/provider.dart';

class SettingsDropdownTile extends StatefulWidget {
  final bool enabled;
  final SettingPreference pref;
  final int cooldown;

  SettingsDropdownTile({
    @required this.pref,
    this.enabled = true,
    this.cooldown,
  }) : assert(pref != null);

  @override
  _SettingsDropdownTileState createState() => _SettingsDropdownTileState();
}

class _SettingsDropdownTileState extends State<SettingsDropdownTile> {
  bool coolingDown = false;

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<PageProvider>();
    final pref = widget.pref;
    final options = widget.pref.options as DropdownOptions;

    return DropdownTile(
      title: pref.title,
      description: pref.description,
      icon: SmartIcon(pref.icon),
      values: options.values,
      value: _provider.getValue(pref.setting),
      onValueChanged: (value) => _provider.setValue(pref.setting, value),
      defaultValue: options.defaultValue,
    );
  }
}

class DropdownTile extends StatefulWidget {
  final String title;
  final String description;
  final Widget icon;
  final Map<String, String> values;
  final String value;
  final ValueChanged<String> onValueChanged;
  final String defaultValue;
  final int cooldown;
  final Color selectedColor;

  DropdownTile({
    @required this.title,
    this.description,
    this.icon,
    @required this.values,
    @required this.value,
    this.onValueChanged,
    this.defaultValue,
    this.cooldown,
    this.selectedColor,
  });

  @override
  _DropdownTileState createState() => _DropdownTileState();
}

class _DropdownTileState extends State<DropdownTile> {
  bool coolingDown = false;

  @override
  Widget build(BuildContext context) {
    final value =
        widget.value ?? widget.defaultValue ?? widget.values.values.first;

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
          selectedColor: widget.selectedColor,
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
              widget.onValueChanged(result);
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
