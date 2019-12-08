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
  final String headerAncestor;

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
    this.headerAncestor,
  })  : assert(footer == null && headerAncestor != null ||
            footer != null && headerAncestor == null),
        assert(title != null),
        assert(setting != null),
        assert(type != null);

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
      icon: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(value.toInt().toString()),
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
      headerAncestor: widget.headerAncestor,
      onTap: widget.onTap,
    );
  }
}
