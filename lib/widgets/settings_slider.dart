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
    var _defaultValue = options.defaultValue.toDouble();
    bool hasReset = false;
    bool isCurrentDefault = false;
    if (_defaultValue != null && _defaultValue == -1) {
      _defaultValue = options.min.toDouble();
      hasReset = true;
      isCurrentDefault = (_provider.getValue(pref.setting)?.toDouble() ??
              options.defaultValue ??
              options.min) ==
          -1;
    }

    double value = _provider.getValue(pref.setting)?.toDouble() ??
        _defaultValue ??
        options.min;
    if (value < options.min || value > options.max)
      value = options.min.toDouble();
    return SizeableListTile(
      title: pref.title,
      icon: Container(
        width: 24,
        alignment: Alignment.center,
        child: isCurrentDefault
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('DEF'),
              )
            : Text((options.percentage
                    ? (value / options.max) * 100
                    : value.toInt())
                .toInt()
                .toString()),
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            child: SettingsSlider(
              value: value,
              min: options.min.toDouble(),
              max: options.max.toDouble(),
              onChanged: (v) {
                _provider.setValue(pref.setting, v);
              },
            ),
          ),
          Visibility(
            visible: hasReset,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () => _provider.setValue(pref.setting, -1),
                icon: Icon(Icons.settings_backup_restore),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSlider extends StatelessWidget {
  final double value;
  final bool enabled;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  SettingsSlider({
    @required this.value,
    this.enabled = true,
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
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
