import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class SettingsSwitch extends StatefulWidget {
  final String title;
  final String setting;
  final SettingType type;
  final String subtitle;
  final String footer;
  final Widget icon;
  final bool enabled;

  final BaseDataProvider provider;

  SettingsSwitch({
    @required this.title,
    @required this.setting,
    @required this.type,
    this.subtitle,
    this.footer,
    this.icon,
    this.provider,
    this.enabled = true,
  })  : assert(title != null),
        assert(setting != null),
        assert(type != null);

  @override
  createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  bool value = false;

  @override
  void initState() {
    updateValue();
    super.initState();
  }

  void updateValue() async {
    await AndroidFlutterSettings.getBool(widget.setting, widget.type).then(
      (b) => setState(() => value = b),
    );
    if (widget.provider != null) {
      widget.provider.data['${widget.type.toString()}/${widget.setting}'] =
          value;
    }
    widget.provider.data = widget.provider.data;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: Theme.of(context).accentColor,
      secondary: Container(
        width: 40,
        child: widget.icon,
      ),
      title: SizeableListTile(
        icon: null,
        title: widget.title,
        subtitle: widget.subtitle,
        footer: widget.footer,
      ),
      value: value,
      onChanged: widget.enabled
          ? (b) async {
              await AndroidFlutterSettings.putBool(
                  widget.setting, b, widget.type);
              updateValue();
            }
          : null,
    );
  }
}
