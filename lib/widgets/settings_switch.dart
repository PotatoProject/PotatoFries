import 'package:flutter/material.dart';
import 'package:potato_fries/internal/common.dart';

class SettingsSwitch extends StatefulWidget {
  final Widget title;
  final String setting;
  final SettingType type;
  final Widget subtitle;
  final Widget icon;
  final bool enabled;

  SettingsSwitch({
    @required this.title,
    @required this.setting,
    @required this.type,
    this.subtitle,
    this.icon,
    this.enabled = true,
  })  : assert(title != null),
        assert(setting != null),
        assert(type != null);
  
  @override createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tmp(),
      initialData: false,
      builder: (context, snapshot) => SwitchListTile(
        activeColor: Theme.of(context).accentColor,
        secondary: Container(
          width: 40,
          child: widget.icon,
        ),
        title: widget.title,
        subtitle: widget.subtitle,
        value: snapshot.data,
        onChanged: widget.enabled ? (b) {} : null,
      ),
    );
  }

  // TODO: Replace with native call
  Future<bool> _tmp() async => false;
}
