import 'package:flutter/material.dart';
import 'package:potato_fries/internal/search_provider.dart';
import 'package:potato_fries/provider/base.dart';
import 'package:potato_fries/ui/color_picker_tile.dart';
import 'package:potato_fries/ui/section.dart';
import 'package:potato_fries/ui/sizeable_list_tile.dart';
import 'package:potato_fries/widgets/settings_slider_tile.dart';
import 'package:potato_fries/widgets/settings_switch_tile.dart';

/// PageLayout
///
/// This file contains the definition of the PageLayout class and all the methods.
/// This class is abstract and needs to be extended before being used anywhere.
///
///
/// What makes a PageLayout?
///
/// A PageLayout is made of simply one thing: a body. This body isn't defined by default (it's abstract)
/// and it has to be defined when extending the class.
/// Basically a body tells what's inside a PageLayout, so all the widgets that compose a page must go in there.
/// A body MUST have Sections as its only root children, anything else is prohibited.
/// A body, when compiled, gets passed a required context and an optional provider, those get used by the
/// widgets inside the function body.
/// The body gets compiled on [PageLayout.build].
///
///
/// More info about [PageLayout.build]
///
/// This is a method that should usually not be overridden, but if you really have to override it, be sure
/// to call the super method.
/// This method basically compiles body, cycles through its children and, by creating a new list, assign to
/// each of them a key, used on ListViews to scroll. When it finishes cycling, it returns a Map, that passes
/// two params: keys body.
/// Keys contains a list of GlobalKeys that were assigned on compilation, its used to the page manager for
/// scrolling to the item when clicked on the search route;
/// Body, as the name suggests, passes the widget to actually build.
///
/// This method gets passed three arguments: context, a selectedIndex and an optional provider.
/// Context and provider get used to call body and to get the contents, while selectedIndex gets used for
/// highlighting the current selected item.
///
///
/// Let's talk about [PageLayout.compileProviders]
///
/// This is a method that should be called only once, at app startup basically. We don't need to compile
/// searchProviders anytime after anyways so it's fine.
/// It basically cycles through the body (and their children ofc) to add every single supported item
/// into the SearchProviders list that gets used to index search items.
/// It uses lots of magic and you don't really need to know how it works, it just works™
///
///
/// Last but not least, [PageLayout.categoryIndex]
///
/// This is really just a little int value that stores the page category index data used for SearchProviders,
/// that's all lol
///
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
        if (body[i].runtimeType.toString() == "Section") {
          Section section = body[i] as Section;
          List<Widget> sectionChildren = section.children;

          for (int j = 0; j < sectionChildren.length; j++) {
            switch (sectionChildren[j].runtimeType.toString()) {
              case "SizeableListTile":
                SizeableListTile tile =
                    (sectionChildren[j] as SizeableListTile);
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
                SettingsSwitchTile tile =
                    (sectionChildren[j] as SettingsSwitchTile);
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
                SettingsSliderTile tile =
                    (sectionChildren[j] as SettingsSliderTile);
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
                      extraData: {
                        "min": tile.min,
                        "max": tile.max,
                        "defval": tile.defval,
                        "percentage": tile.percentage,
                        "percentageMode": tile.percentageMode
                      }),
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
                      headerAncestor: section.title),
                );
                break;
              default:
                //not supported
                break;
            }
          }
        } else
          throw Exception(
              "Every element on the root of a PageLayout must be a Section");
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
