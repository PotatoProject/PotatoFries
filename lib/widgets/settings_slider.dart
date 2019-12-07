import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class SettingsSlider extends StatefulWidget {
  final String title;
  final String setting;
  final SettingType type;
  final String subtitle;
  final bool enabled;
  final double min;
  final double max;
  final double defval;
  final BaseDataProvider provider;

  SettingsSlider({
    @required this.title,
    @required this.setting,
    @required this.type,
    this.subtitle,
    this.enabled = true,
    this.min = 0,
    this.max = 0,
    this.provider,
    this.defval,
  })  : assert(title != null),
        assert(setting != null),
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

  void updateValue() async {
    await AndroidFlutterSettings.getInt(widget.setting, widget.type).then(
          (v) => setState(() => value = v.toDouble()),
    );
    if (widget.provider != null) {
      widget.provider.data['${widget.type.toString()}/${widget.setting}'] =
          value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        child: Center(
          child: Text(value.toInt().toString()),
        ),
      ),
      title: SizeableListTile(
        icon: null,
        title: widget.title,
        subtitle: widget.subtitle,
      ),
      subtitle: Slider(
        min: widget.min,
        max: widget.max,
        value: value,
        onChanged: widget.enabled ? (v) async {
          await AndroidFlutterSettings.putInt(widget.setting, v.toInt(), widget.type);
          updateValue();
        } : null,
      ),
      trailing: Visibility(
        visible: widget.defval != null,
        child: IconButton(
          icon: Icon(Icons.restore),
          onPressed: () {},
        ),
      ),
    );
  }
}
