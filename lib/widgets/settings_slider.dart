import 'package:flutter/material.dart';
import 'package:potato_fries/data/models.dart';
import 'package:potato_fries/provider/page_provider.dart';
import 'package:potato_fries/ui/custom_track_shape.dart';
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
    final isCurrentlyDefault = value == -1;

    value = value.clamp(options.min, options.max);

    return SizeableListTile(
      title: pref.title,
      icon: SizedBox.fromSize(
        size: Size.square(24),
        child: Center(
          child: isCurrentlyDefault
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
      subtitle: SettingsSlider(
        value: value.toDouble(),
        min: options.min.toDouble(),
        max: options.max.toDouble(),
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

class SettingsSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  SettingsSlider({
    @required this.value,
    this.min = 0,
    this.max = 0,
    this.onChanged,
  }) : assert(value != null);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
      ),
      child: Slider(
        min: min,
        max: max,
        value: value,
        divisions: max.toInt() - 1,
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Theme.of(context).accentColor.withOpacity(0.25),
        onChanged: onChanged,
      ),
    );
  }
}
