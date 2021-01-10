import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:provider/provider.dart';

class SettingsSliderTile extends StatefulWidget {
  final SettingPreference pref;

  SettingsSliderTile({
    @required this.pref,
  }) : assert(pref != null);

  @override
  _SettingsSliderTileState createState() => _SettingsSliderTileState();
}

class _SettingsSliderTileState extends State<SettingsSliderTile> {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<PageProvider>();
    final pref = widget.pref;
    final options = widget.pref.options as SliderOptions;

    int value = _provider.getValue(pref.setting) ?? options.defaultValue;
    final showDefaultText = value == -1;
    final isCurrentlyDefault = value == options.defaultValue;

    value = value.clamp(options.min, options.max);

    return SizeableListTile(
      title: pref.title,
      icon: SizedBox.fromSize(
        size: Size.square(24),
        child: Center(
          child: showDefaultText
              ? FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('DEF'),
                )
              : Text(
                  (options.percentage ? (value / options.max) * 100 : value)
                      .toInt()
                      .toString(),
                ),
        ),
      ),
      subtitle: Slider(
        value: value.toDouble(),
        min: options.min.toDouble(),
        max: options.max.toDouble(),
        divisions: options.max.toInt() - 1,
        onChanged: (v) {
          _provider.setValue(pref.setting, v.toInt());
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.settings_backup_restore),
        onPressed: !isCurrentlyDefault
            ? () => _provider.setValue(pref.setting, options.defaultValue)
            : null,
      ),
    );
  }
}
