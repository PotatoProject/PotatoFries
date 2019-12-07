import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';

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
  bool currentState = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSettingValue(),
      initialData: false,
      builder: (context, snapshot) => Switch(
        activeColor: Theme.of(context).accentColor,
        value: snapshot.data,
        onChanged: widget.enabled ? (value) async {
          bool newValue = await AndroidFlutterSettings.putBool(widget.setting, value, widget.type);
          setState(() => currentState = newValue);
        } : null,
      ),
    );
  }

  Future<bool> getSettingValue() async {
    currentState = await AndroidFlutterSettings.getBool(widget.setting, widget.type);
    return currentState;
  }
}