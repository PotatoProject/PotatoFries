import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/ui/smart_icon.dart';
import 'package:provider/provider.dart';

class SettingsSwitchTile extends StatefulWidget {
  final SettingPreference pref;

  SettingsSwitchTile({
    @required this.pref,
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
      trailing: Switch(
        onChanged: (v) => _provider.setValue(pref.setting, v),
        value: value,
      ),
      onTap: () => _provider.setValue(pref.setting, !value),
    );
  }
}
