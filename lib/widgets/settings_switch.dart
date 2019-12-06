import 'package:flutter/material.dart';
import 'package:potato_fries/internal/common.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class SettingsSwitch extends StatefulWidget {
  final String title;
  final String setting;
  final SettingType type;
  final String subtitle;
  final String footer;
  final Widget icon;
  final bool enabled;
  final String headerAncestor;

  SettingsSwitch({
    @required this.title,
    @required this.setting,
    @required this.type,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    this.headerAncestor,
  })  : assert(
          footer == null && headerAncestor != null ||
          footer != null && headerAncestor == null
        ),
        assert(title != null),
        assert(setting != null),
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
      builder: (context, snapshot) => SwitchListTile(
        activeColor: Theme.of(context).accentColor,
        secondary: Container(
          width: 40,
          child: widget.icon,
        ),
        title: SizeableListTile(
          icon: null,
          title: widget.title,
          subtitle: widget.subtitle ?? null,
          footer: widget.footer,
          headerAncestor: widget.headerAncestor,
        ),
        value: snapshot.data,
        onChanged: widget.enabled ? (b) {} : null,
      ),
    );
  }

  // TODO: Replace with native call
  Future<bool> _tmp() async => false;
}
