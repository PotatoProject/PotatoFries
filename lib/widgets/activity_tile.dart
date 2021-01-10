import 'package:flutter/material.dart';
import 'package:potato_fries/utils/utils.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String footer;
  final Widget icon;
  final bool enabled;
  final String cls;
  final String pkg;

  ActivityTile({
    @required this.title,
    this.subtitle,
    this.footer,
    this.icon,
    this.enabled = true,
    @required this.cls,
    @required this.pkg,
  })  : assert(title != null),
        assert(cls != null),
        assert(pkg != null);

  @override
  Widget build(BuildContext context) {
    return SizeableListTile(
      title: title,
      icon: icon,
      subtitle: subtitle == null ? null : Text(subtitle),
      footer: footer,
      onTap: () => Utils.startActivity(pkg: pkg, cls: cls),
    );
  }
}
