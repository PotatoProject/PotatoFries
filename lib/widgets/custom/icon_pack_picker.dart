import 'package:flutter/material.dart';
import 'package:potato_fries/data/constants.dart';
import 'package:potato_fries/provider/app_info.dart';
import 'package:potato_fries/widgets/settings_dropdown.dart';
import 'package:provider/provider.dart';

class IconPackPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsDropdownTile(
      title: 'Icon Pack',
      subtitle: 'Pick system icon pack (will reload Fries!)',
      icon: Icon(Icons.apps),
      setValue: (val) =>
          Provider.of<AppInfoProvider>(context).setIconPack(int.parse(val)),
      getValue: () =>
          Provider.of<AppInfoProvider>(context).getIconPackIndex().toString(),
      values: Map.fromIterable(
        iconPackLabels,
        key: (element) => iconPackLabels.indexOf(element).toString(),
        value: (element) => element,
      ),
    );
  }
}
