import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_slider.dart';

class SettingsSliderTile extends StatefulWidget {
  final String title;
  final String setting;
  final SettingType type;
  final String footer;
  final bool enabled;
  final double min;
  final double max;
  final double defval;
  final Function() onTap;
  final BaseDataProvider provider;
  final bool percentage;
  final PercentageMode percentageMode;

  SettingsSliderTile({
    @required this.title,
    @required this.setting,
    @required this.type,
    this.footer,
    this.enabled = true,
    this.onTap,
    this.min = 0,
    this.max = 0,
    this.provider,
    this.defval,
    this.percentage = false,
    this.percentageMode = PercentageMode.ABSOLUTE,
  })  : assert(title != null),
        assert(setting != null),
        assert(type != null),
        assert(percentage != null),
        assert(percentageMode != null);

  @override
  _SettingsSliderTileState createState() => _SettingsSliderTileState();
}

class _SettingsSliderTileState extends State<SettingsSliderTile> {
  double value = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        type: widget.type,
        setting: widget.setting,
        enabled: widget.enabled,
        provider: widget.provider,
        min: widget.min,
        max: widget.max,
        onChanged: (v) => setState(() => value = v),
      ),
      footer: widget.footer,
      onTap: widget.onTap,
    );
  }
}

enum PercentageMode { RELATIVE, ABSOLUTE }
