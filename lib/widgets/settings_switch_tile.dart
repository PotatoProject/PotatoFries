import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final String setting;
  final SettingType type;
  final String subtitle;
  final String footer;
  final Widget icon;
  final bool enabled;
  final Function() onTap;
  final BaseDataProvider provider;
  final String headerAncestor;

  SettingsSwitchTile({
    @required this.title,
    @required this.setting,
    @required this.type,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    this.onTap,
    this.provider,
    this.headerAncestor,
  })  : assert(footer == null && headerAncestor != null ||
            footer != null && headerAncestor == null),
        assert(title != null),
        assert(setting != null),
        assert(type != null);

  @override
  Widget build(BuildContext context) {
    return SizeableListTile(
      title: title,
      icon: icon,
      subtitle: subtitle == null ? null : Text(subtitle),
      footer: footer,
      headerAncestor: headerAncestor,
      trailing: SettingsSwitch(
        type: type,
        setting: setting,
        enabled: enabled,
        provider: provider,
      ),
      onTap: onTap,
    );
  }
}
