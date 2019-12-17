import 'package:flutter/material.dart';
import 'package:potato_fries/ui/custom_track_shape.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class SettingsSliderTile extends StatefulWidget {
  final String title;
  final String footer;
  final bool enabled;
  final double min;
  final double max;
  final bool percentage;
  final PercentageMode percentageMode;
  final Function setValue;
  final Function getValue;

  SettingsSliderTile({
    @required this.title,
    this.footer,
    this.enabled = true,
    this.min = 0,
    this.max = 0,
    this.percentage = false,
    this.percentageMode = PercentageMode.ABSOLUTE,
    @required this.setValue,
    @required this.getValue,
  })  : assert(title != null),
        assert(percentage != null),
        assert(percentageMode != null),
        assert(setValue != null),
        assert(getValue != null);

  @override
  _SettingsSliderTileState createState() => _SettingsSliderTileState();
}

class _SettingsSliderTileState extends State<SettingsSliderTile> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    value = widget.getValue()?.toDouble() ?? widget.min;
    if (value < widget.min || value > widget.max) value = widget.min;
    return SizeableListTile(
      title: widget.title,
      icon: Container(
        width: 24,
        alignment: Alignment.center,
        child: Text((widget.percentage
                ? widget.percentageMode == PercentageMode.ABSOLUTE
                    ? (value / widget.max) * 100
                    : ((value - widget.min) / (widget.max - widget.min)) * 100
                : value.toInt())
            .toInt()
            .toString()),
      ),
      subtitle: SettingsSlider(
        value: value,
        enabled: widget.enabled,
        min: widget.min,
        max: widget.max,
        onChanged: (v) {
          setState(() => value = v);
          widget.setValue(v);
        },
      ),
      footer: widget.footer,
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
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Theme.of(context).accentColor.withOpacity(0.25),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}

enum PercentageMode { RELATIVE, ABSOLUTE }
