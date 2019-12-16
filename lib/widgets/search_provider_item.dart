import 'package:flutter/material.dart';
import 'package:potato_fries/internal/page_data.dart';
import 'package:potato_fries/internal/search_provider.dart';
import 'package:potato_fries/pages/buttons_and_navigation.dart';
import 'package:potato_fries/pages/quick_settings.dart';
import 'package:potato_fries/pages/themes.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_slider_tile.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';

class SearchProviderItem extends StatelessWidget {
  final SearchProvider provider;

  SearchProviderItem({
    @required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    if (provider.setting != null) {
      switch (provider.inputType) {
        case SettingInputType.SWITCH:
          return SettingsSwitchTile(
            icon: provider.icon,
            setting: provider.setting,
            type: provider.type,
            title: provider.title,
            subtitle:
                provider.description != null ? provider.description : null,
            provider: provider.provider,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => executePush(),
              ),
            ),
            footer: parseCategory(provider) +
                (provider.headerAncestor != null
                    ? " > " + provider.headerAncestor
                    : ""),
          );
          break;
        case SettingInputType.SLIDER:
          return SettingsSliderTile(
            setting: provider.setting,
            type: provider.type,
            title: provider.title,
            provider: provider.provider,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => executePush(),
              ),
            ),
            footer: parseCategory(provider) +
                (provider.headerAncestor != null
                    ? " > " + provider.headerAncestor
                    : ""),
            min: provider.extraData["min"],
            max: provider.extraData["max"],
            defval: provider.extraData["defval"],
            percentage: provider.extraData["percentage"],
            percentageMode: provider.extraData["percentageMode"],
          );
          break;
        default:
          return SizeableListTile(
            icon: provider.icon,
            title: provider.title,
            subtitle: provider.description != null
                ? Text(provider.description)
                : null,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => executePush(),
              ),
            ),
            footer: parseCategory(provider) +
                (provider.headerAncestor != null
                    ? " > " + provider.headerAncestor
                    : ""),
          );
      }
    } else {
      return SizeableListTile(
        icon: provider.icon,
        title: provider.title,
        subtitle:
            provider.description != null ? Text(provider.description) : null,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => executePush(),
          ),
        ),
        footer: parseCategory(provider) +
            (provider.headerAncestor != null
                ? " > " + provider.headerAncestor
                : ""),
      );
    }
  }

  String parseCategory(SearchProvider provider) =>
      (pages[provider.categoryIndex] as dynamic).title;

  Widget executePush() {
    switch (provider.categoryIndex) {
      case 0:
        return QuickSettings(bloc: bloc, keyIndex: provider.itemPosition);
      case 1:
        return ButtonsAndNavigation(
            bloc: bloc, keyIndex: provider.itemPosition);
      case 2:
        return Themes(bloc: bloc, keyIndex: provider.itemPosition);
      default:
        return Container();
    }
  }
}
