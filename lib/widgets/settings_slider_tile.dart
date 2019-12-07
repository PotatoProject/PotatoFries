import 'package:android_flutter_settings/android_flutter_settings.dart';
import 'package:flutter/material.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_slider.dart';

class SettingsSliderTile extends StatelessWidget {
  final String title;
  final String setting;
  final SettingType type;
  final String footer;
  final Widget icon;
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
    this.icon,
    this.enabled = true,
    this.onTap,
    this.min = 0,
    this.max = 0,
    this.provider,
    this.defval,
    this.headerAncestor,
  })  : assert(
          footer == null && headerAncestor != null ||
          footer != null && headerAncestor == null
        ),
        assert(title != null),
        assert(setting != null),
        assert(type != null);
  
  @override
  Widget build(BuildContext context) {
    return SizeableListTile(
      title: title,
      icon: icon,
      subtitle: SettingsSlider(
        type: type,
        setting: setting,
        enabled: enabled,
        provider: provider,
      ),
      footer: footer,
      headerAncestor: headerAncestor,
      onTap: onTap,
    );
  }
}