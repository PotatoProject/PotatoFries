import 'package:flutter/material.dart';
import 'package:potato_fries/internal/search_provider.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_switch.dart';

abstract class PageLayout {
  List<Widget> body(BuildContext context);

  void compileProviders(BuildContext context) {
    List<Widget> body = this.body(context);

    for(int i = 0; i < body.length; i++) {
      if(searchItems.where((item) => item.title == (body[i] as dynamic).title).length == 0) {
        switch(body[i].runtimeType.toString()) {
          case "SizeableListTile":
            SizeableListTile tile = (body[i] as SizeableListTile);

            searchItems.add(SearchProvider(
              title: tile.title,
              description: tile.subtitle,
              icon: tile.icon,
              itemPosition: i,
              categoryIndex: 2
            ));

            break;
          case "SettingsSwitch":
            SettingsSwitch tile = (body[i] as SettingsSwitch);

            searchItems.add(SearchProvider(
              title: tile.title,
              setting: tile.setting,
              type: tile.type,
              inputType: SettingInputType.SWITCH,
              description: tile.subtitle,
              icon: tile.icon,
              itemPosition: i,
              categoryIndex: 2
            ));

            break;
          default:
            //not supported
            break;
        }
      }
    }
  }

  Map<String, dynamic> build(BuildContext context, int selectedIndex) {
    List<Widget> body = this.body(context);

    if(body == null) {
      throw Exception("PageLayout can't have a null body, please define one if you plan on using it anywhere.");
    }

    List<GlobalKey> keys = List.generate(body.length, (_) => GlobalKey());

    List<Widget> widgets = List.generate(body.length, (index) {
      return Container(
        key: keys[index],
        color: index == selectedIndex ? Theme.of(context).accentColor.withAlpha(120) : null,
        child: body[index],
      );
    });

    return {
      'keys': keys,
      'body': widgets
    };
  }
}