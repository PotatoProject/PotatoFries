import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/custom_track_shape.dart';

class SettingsSlider extends StatefulWidget {
  final String setting;
  final SettingType type;
  final bool enabled;
  final double min;
  final double max;
  final double defval;
  final BaseDataProvider provider;
  final ValueChanged<double> onChanged;

  SettingsSlider({
    @required this.setting,
    @required this.type,
    this.enabled = true,
    this.min = 0,
    this.max = 0,
    this.provider,
    this.defval,
    this.onChanged,
  })  : assert(setting != null),
        assert(type != null);

  @override
  createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {
  double value = 0;

  @override
  void initState() {
    value = widget.min;
    updateValue();
    super.initState();
  }

  Future<void> updateValue() async {
    await AndroidFlutterSettings.getInt(widget.setting, widget.type).then(
      (v) => setState(() => value = v.toDouble()),
    );
    if (widget.provider != null) {
      widget.provider.data['${widget.type.toString()}/${widget.setting}'] =
          value;
      widget.provider.data = widget.provider.data;
    }
    if (widget.onChanged != null) widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
      ),
      child: Slider(
        min: widget.min,
        max: widget.max,
        value: value,
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Theme.of(context).accentColor.withAlpha(120),
        onChanged: widget.enabled
            ? (v) async {
                await AndroidFlutterSettings.putInt(
                    widget.setting, v.toInt(), widget.type);
                updateValue();
                if (widget.onChanged != null) widget.onChanged(value);
              }
            : null,
      ),
    );
  }
}
