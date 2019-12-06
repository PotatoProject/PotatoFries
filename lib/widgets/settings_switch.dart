import 'package:flutter/material.dart';
import 'package:potato_fries/internal/common.dart';

class SettingsSwitch extends StatefulWidget {
  final String setting;
  final SettingType type;
  final bool enabled;

  SettingsSwitch({
    @required this.setting,
    @required this.type,
    this.enabled = true,
  }) : assert(setting != null),
       assert(type != null);

  @override
  createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _tmp(),
      initialData: false,
      builder: (context, snapshot) => Switch(
        activeColor: Theme.of(context).accentColor,
        value: snapshot.data,
        onChanged: widget.enabled ? (b) {} : null,
      ),
    );
  }

  // TODO: Replace with native call
  Future<bool> _tmp() async => false;
}