import 'package:flutter/material.dart';
import 'package:potato_fries/internal/search_provider.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/color_picker_tile.dart';
import 'package:potato_fries/ui/section.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_slider_tile.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';

abstract class PageLayout {
  List<Widget> body(BuildContext context, {BaseDataProvider provider});

  /// This value represents what category is the pagelayout
  /// 0 = qs panel
  /// 1 = navigation
  /// 2 = themes
  /// 3 = status bar
  /// 4 = lockscreen
  int categoryIndex = 0;

  void compileProviders(BuildContext context) {
    List<Widget> body = this.body(context);

    for (int i = 0; i < body.length; i++) {
      if (searchItems
              .where((item) => item.title == (body[i] as dynamic).title)
              .length ==
          0) {
        if(body[i].runtimeType.toString() == "Section") {
          Section section = body[i] as Section;
          List<Widget> sectionChildren = section.children;

          for(int j = 0; j < sectionChildren.length; j++) {
            switch (sectionChildren[j].runtimeType.toString()) {
              case "SizeableListTile":
                SizeableListTile tile = (sectionChildren[j] as SizeableListTile);
                searchItems.add(
                  SearchProvider(
                    title: tile.title,
                    description: (tile.subtitle as Text).data,
                    icon: tile.icon,
                    itemPosition: j,
                    categoryIndex: categoryIndex,
                    headerAncestor: section.title,
                  ),
                );
                break;
              case "SettingsSwitchTile":
                SettingsSwitchTile tile = (sectionChildren[j] as SettingsSwitchTile);
                searchItems.add(
                  SearchProvider(
                    title: tile.title,
                    setting: tile.setting,
                    type: tile.type,
                    inputType: SettingInputType.SWITCH,
                    description: tile.subtitle,
                    icon: tile.icon,
                    itemPosition: j,
                    categoryIndex: categoryIndex,
                    headerAncestor: section.title,
                    provider: tile.provider,
                  ),
                );
                break;
              case "SettingsSliderTile":
                SettingsSliderTile tile = (sectionChildren[j] as SettingsSliderTile);
                searchItems.add(
                  SearchProvider(
                    title: tile.title,
                    setting: tile.setting,
                    type: tile.type,
                    inputType: SettingInputType.SLIDER,
                    itemPosition: j,
                    categoryIndex: categoryIndex,
                    headerAncestor: section.title,
                    provider: tile.provider,
                    min: tile.min,
                    max: tile.max,
                    defval: tile.defval
                  ),
                );
                break;
              case "ColorPickerTile":
                ColorPickerTile tile = (sectionChildren[j] as ColorPickerTile);
                searchItems.add(
                  SearchProvider(
                    title: tile.title,
                    description: tile.subtitle,
                    icon: Icon(Icons.color_lens),
                    itemPosition: j,
                    categoryIndex: categoryIndex,
                  ),
                );
                break;
              default:
                //not supported
                break;
            }
          }
        } else throw Exception("Every element on the root of a PageLayout must be a Section");
      }
    }
  }

  Map<String, dynamic> build(
    BuildContext context,
    int selectedIndex, {
    BaseDataProvider provider,
  }) {
    List<Widget> body = this.body(context, provider: provider);

    if (body == null) {
      throw Exception(
        "PageLayout can't have a null body, please define one if you plan on using it anywhere.",
      );
    }

    List<GlobalKey> keys = List.generate(body.length, (_) => GlobalKey());

    List<Widget> widgets = List.generate(
      body.length,
      (index) {
        return Container(
          key: keys[index],
          color: index == selectedIndex
              ? Theme.of(context).accentColor.withAlpha(120)
              : null,
          child: body[index],
        );
      },
    );

    return {
      'keys': keys,
      'body': widgets,
    };
  }
}
