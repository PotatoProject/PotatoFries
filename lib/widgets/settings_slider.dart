import 'package:flutter/material.dart';
import 'package:potato_fries/internal/common.dart';

class SettingsSlider extends StatefulWidget {
  final Widget title;
  final String setting;
  final SettingType type;
  final double initial;
  final Widget subtitle;
  final bool enabled;
  final double min;
  final double max;

  SettingsSlider({
    @required this.title,
    @required this.setting,
    @required this.type,
    @required this.initial,
    this.subtitle,
    this.enabled = true,
    this.min = 0,
    this.max = 0,
  })  : assert(title != null),
        assert(setting != null),
        assert(type != null);
  
  @override createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tmp(),
      builder: (context, snapshot) {
        return ListTile(
          leading: Container(
            width: 40,
            child: Center(
              child: Text(
                snapshot.data.toString().substring(0, 1)
              ),
            ),
          ),
          title: widget.title,
          subtitle: Slider(
            min: widget.min,
            max: widget.max,
            value: snapshot.data,
            onChanged: widget.enabled ? (v) {} : null,
          ),
          trailing: IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {},
          ),
        );
      },
    );
  }

  // TODO: Replace with native call
  Future<double> _tmp() async => 0;
}