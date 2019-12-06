import 'package:flutter/material.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/internal/search_provider.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

class SearchProviderItem extends StatelessWidget {
  final SearchProvider provider;

  SearchProviderItem({
    @required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    if(provider.setting != null && provider.inputType == SettingInputType.SWITCH) {
      return SettingsSwitch(
        icon: Container(
          width: 40,
          child: provider.icon,
        ),
        setting: provider.setting,
        type: provider.type,
        title: provider.title,
        subtitle: provider.description != null ?
            provider.description :
            null,
        footer: parseCategory(provider) +
            (provider.headerAncestor != null ?
                " > " + provider.headerAncestor :
                ""),
      );
    } else {
      return SizeableListTile(
        icon: Container(
          width: 40,
          child: provider.icon,
        ),
        title: provider.title,
        subtitle: provider.description != null ?
            provider.description :
            null,
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => executePush()
        )),
        footer: parseCategory(provider) +
            (provider.headerAncestor != null ?
                " > " + provider.headerAncestor :
                ""),
      );
    }
  }

  String parseCategory(SearchProvider provider) {
    return (pages[provider.categoryIndex] as dynamic).title;
  }

  Widget executePush() {
    switch(provider.categoryIndex) {
      case 2:
        return Themes(bloc: bloc, keyIndex: provider.itemPosition);
    }
  }
}