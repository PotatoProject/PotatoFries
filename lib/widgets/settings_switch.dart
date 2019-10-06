import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tmp(),
      initialData: false,
      builder: (context, snapshot) => SwitchListTile(
        activeColor: Theme.of(context).accentColor,
        secondary: Container(
          width: 40,
          child: icon,
        ),
        title: title,
        subtitle: subtitle,
        value: snapshot.data,
        onChanged: enabled ? (b) {} : null,
      ),
    );
  }

  // TODO: Replace with native call
  Future<bool> _tmp() async => false;
}

enum SettingType {
  SECURE,
  SYSTEM,
  GLOBAL,
}
